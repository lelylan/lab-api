class ProjectsController < ApplicationController
  before_filter :find_resources
  before_filter :find_resource, only: %w(show update destroy)
  before_filter :search_params, only: %w(index public)
  before_filter :pagination,    only: %w(index public)

  doorkeeper_for :index, :show, :create, scopes: [:user]

  respond_to :json

  # GET /projects
  # GET /projects?since=:since
  def index
    current_user ? @projects = @projects.where(user_id: current_user.id, confirmed: true).recent : render_404

    @projects = @projects.where(:updated_at.gte => params[:since]) if params.key?(:since)
    render json: @projects, each_serialzier: ProjectSerializer
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    project = Project.where(user_id: current_user.id).where(id: params[:id]).first
    project ? render(json: project, serializer: ProjectSerializer) : render_404
  end

  # POST /projects
  # POST /projects.json
  def create
    unless current_user.promoter || current_user.class == Admin
      !params[:user_id].nil? ? render(json: { errors: 'Unexpecting user_id param' }, status: 422) && return : params[:user_id] = current_user.id.to_s
    end

    render(json: { errors: 'Expecting user_id param' }, status: 422) && return if params[:user_id].nil?
    @project = Project.create_or_update_in_time(project_params)

    if @project.save
      render json: @project, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  private

  def project_params
    params.permit(:user_id, :head, :neck, :shoulders, :chest, :waistline, :pelvis, :hips, :thigh, :confirmed, :height, :weight)
  end

  # find all resources
  def find_resources
    @projects = Project.all
  end

  # find the desired resource
  def find_resource
    @project = @projects.find(params[:id])
  end

  # set the searchable params
  # see http://mongoid.org/en/mongoid/docs/querying.html#query_plus
  def search_params
    @projects = @projects.where(name: Regexp.new(Regexp.escape(name), Regexp::IGNORECASE)) if params[:name]
  end

  # set the pagination list
  # see http://uxdesign.smashingmagazine.com/2013/05/03/infinite-scrolling-get-bottom/
  def pagination
    params.key?(:page) ? page_number = params[:page].to_i : page_number = 1
    @projects = @projects.page(page_number)
    @projects = @projects.per(params[:per]) if params.key?(:per)
  end

  def current_user
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
