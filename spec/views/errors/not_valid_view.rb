module ViewNotValidMethods
  # Resource not valid
  def not_valid_resource?(options = {})
    options = not_valid_default.merge(options)
    json = JSON.parse(page.source)
    json = Hashie::Mash.new json
    expect(json.request).to match Regexp.escape(uri)
    expect(json.status).to eq 422
    expect(json[:method]).to eq options[:method]
    expect(json.error.code).to eq options[:code]
    page.should have_content options[:error]
  end

  def not_valid_default
    { method: 'POST',
      code: 'notifications.resource.not_valid',
      error: 'uri is not a valid' }
  end
end

RSpec.configuration.include ViewNotValidMethods
