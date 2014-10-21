# Personalized macros
# see http://benmabey.com/2008/06/08/writing-macros-in-rspec.html

module SharedMacros
  def valid_json?
    expect { JSON.parse(page.source) }.to_not raise_error
  end

  def build_params(params, access_token)
    params[:access_token] = access_token.token
    params
  end
end

RSpec.configuration.include SharedMacros
