class ProjectsController < ApplicationController

  doorkeeper_for :index, :create, :update, :destroy

  before_filter :find_public_resources, only: %w(public show)
  before_filter :find_owned_resources, except: %w(public show)
  before_filter :find_resource, only: %w(show update destroy)
  before_filter :search_params, only: %w(index public)
  before_filter :order_params, only: %w(index public)
  before_filter :pagination, only: %w(index public)


  def index
    @projects = @projects.asc(:id).limit(params[:per])
    render json: @projects
  end

  def show
    render json: @project if stale?(@project)
  end

  def create
    @project = Project.new(project_params)
    @project.resource_owner_id = current_user.id
    if @project.save
      render json: @project, status: 201, location: @project.decorate.uri
    else
      render_422 'notifications.resource.not_valid', @project.errors
    end
  end

  def update
    if @project.update_attributes(project_params)
      render json: @project
    else
      render_422 'notifications.resource.not_valid', @project.errors
    end
  end

  def destroy
    render json: @project
    @project.destroy
  end

  def public
    @projects = @projects.limit(params[:per])
    render json: @projects
  end


  private

  def project_params
    params.permit(:name, :description, :link, :tags, :image_data, :content_type, :original_filename)
  end

  def find_public_resources
    @projects = Project.all
  end

  def find_owned_resources
    @projects = Project.where(resource_owner_id: current_user.id)
  end

  def find_resource
    @project = @projects.find(params[:id])
  end

  def search_params
    @projects = @projects.where('name' => /.*#{params[:name]}.*/i) if params[:name]
    @projects = @projects.where('description' => /.*#{params[:description]}.*/i) if params[:description]
    @projects = @projects.tagged_with(params[:tag]) if params[:tag]
  end

  def order_params
    @projects = @projects.desc(:views) if params[:order] == 'views'
    @projects = @projects.desc(:likes) if params[:order] == 'likes'
  end

  def pagination
    params[:per] = (params[:per] || Settings.pagination.per).to_i
    params[:per] = Settings.pagination.per if params[:per] == 0
    params[:per] = Settings.pagination.max_per if params[:per] > Settings.pagination.max_per
    @projects = @projects.gt(id: params[:start]) if params[:start]
  end
end

