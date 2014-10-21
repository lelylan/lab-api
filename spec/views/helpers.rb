module HelperViewMethods
  def contains_owned_resource(resource)
    resource  = get_decorator.decorate resource
    json      = JSON.parse response.body
    contains_resource resource
  end

  def contains_resource(resource)
    resource = get_decorator.decorate resource
    json     = JSON.parse(response.body).first
    has_resource resource, json
  end

  def has_resource(resource, json = nil)
    valid_json?

    resource = get_decorator.decorate(resource)
    json = JSON.parse(response.body) unless json
    json = Hashie::Mash.new json

    eval "has_#{controller.singularize}(resource, json)"
  end

  def does_not_contain_resource(resource)
    expect(response.body).to_not match(resource.id.to_s)
  end

  private

  def get_decorator
    "#{controller.classify}Decorator".constantize
  end
end

RSpec.configuration.include HelperViewMethods
