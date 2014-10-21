module ViewNotFoundMethods

  def has_not_found_resource(options={})
    options = not_found_default.merge(options)
    json = JSON.parse(response.body)
    json = Hashie::Mash.new json

    expect(json.status).to eq(404)
    expect(json.error.code).to eq(options[:code])
    expect(json.error.uri).to match(Regexp.escape(options[:uri])) if options[:uri].is_a? String
    expect(json.error.uri).to eq(options[:uri]) if options[:uri].is_a? Array
  end

  def not_found_default
    { method: 'GET',
      code:   'notifications.resource.not_found' }
  end
end

RSpec.configuration.include ViewNotFoundMethods
