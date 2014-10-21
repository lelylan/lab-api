class ProjectsController < ApplicationController
  doorkeeper_for :all # , except: :index

  before_filter :find_owned_resources
  before_filter :find_resource, only: %w(show update destroy)
  before_filter :search_params, only: %w(index)
  before_filter :pagination,    only: %w(index)


  def index
    @projects = @projects.desc(:id).limit(params[:per])
    render json: @projects
  end

  def show
    render json: @project if stale?(@project)
  end

  def create
    process_image
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


  private

  def project_params
    params.permit(:name, :description, :image_data, :content_type, :original_filename)
  end

  def process_image

    if params[:image] and params[:image][:data]
      data = StringIO.new(Base64.decode64(params[:image][:data]))
      data.class.class_eval { attr_accessor :original_filename, :content_type }
      data.original_filename = params[:image][:filename]
      data.content_type = params[:image][:content_type]
      params[:image] = data
    end
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
  end

  def pagination
    params[:per] = (params[:per] || Settings.pagination.per).to_i
    params[:per] = Settings.pagination.per if params[:per] == 0
    params[:per] = Settings.pagination.max_per if params[:per] > Settings.pagination.max_per
    @projects = @projects.gt(id: params[:start]) if params[:start]
  end
end

