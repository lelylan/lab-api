require 'spec_helper'

describe Doorkeeper::AccessToken do

  let(:token) { FactoryGirl.create :access_token }

  it 'connects to people database' do
    expect(Doorkeeper::AccessToken.database_name).to be(:people_test)
  end

  it 'creates an access token' do
    expect(token.id).to_not be_nil
  end
end
