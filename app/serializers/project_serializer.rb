class ProjectSerializer < ApplicationSerializer
  attributes  :uri, :name

  def uri
    ProjectDecorator.decorate(object).uri
  end

  def cache_key
    object.cache_key
  end
end
