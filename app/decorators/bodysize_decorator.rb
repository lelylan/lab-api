class ProjectDecorator < ApplicationDecorator

  decorates :Project

  def uri
    h.project_path(model, default_options)
  end

end
