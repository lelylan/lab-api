module HelpersViewMethods
  def has_project(resource, json = nil)
    expect(json.uri).to_not be_nil
    expect(json.id).to eq(resource.object.id.to_s)
    expect(json.name).to eq(resource.object.name)
    expect(json.description).to eq(resource.object.description)
    expect(json.image).to eq(resource.object.image.url)
  end
end

RSpec.configuration.include HelpersViewMethods
