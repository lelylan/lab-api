require 'spec_helper'

describe Doorkeeper::AccessGrant do

  let(:token) { FactoryGirl.create :access_grant }

  it 'connects to people database' do
    expect(Doorkeeper::AccessGrant.database_name).to be(:people_test)
  end

  it 'creates an access grant' do
    expect(token.id).to_not be_nil
  end
end
