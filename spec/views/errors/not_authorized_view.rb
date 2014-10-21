module ViewNotAuthorizedMethods
  def unauthorized_resource?
    json = JSON.parse(page.source)
    json = Hashie::Mash.new json

    expect(json.status).to be 401
    expect(json.request).to eq page.current_url

    expect(json.error.code).to eq 'notifications.access.not_authorized'
    expect(json.error.description).to eq 'Token not valid'
  end
end

RSpec.configuration.include ViewNotAuthorizedMethods
