module ViewNotFoundMethods
  def not_found_resource?(options = {})
    options = not_found_default.merge(options)
    json = JSON.parse(page.source)
    json = Hashie::Mash.new json
    expect(json.status).to be 404
    expect(json.error.code).to eq options[:code]
    json.error.uri.should match Regexp.escape(options[:uri])
  end

  def not_found_default
    { method: 'GET',
      code:   'notifications.resource.not_found' }
  end
end

RSpec.configuration.include ViewNotFoundMethods
