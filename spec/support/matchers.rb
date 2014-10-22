RSpec::Matchers.define :authorize do |expected|
  match do |actual|
    method, uri, params, auth = expected.squish.split ' '
    send method, uri, params, auth
    page.status_code != 401
  end
end

RSpec::Matchers.define :have_the_same_time_as do |expected|
  match do |actual|
    expected.to_i == actual.to_i
  end
end

