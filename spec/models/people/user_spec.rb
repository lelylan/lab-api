require 'spec_helper'

describe User do

  let(:user) { FactoryGirl.create :user }

  it 'connects to people database' do
    expect(User.database_name).to eq(:people_test)
  end

  it 'creates a user' do
    expect(user.id).to_not be_nil
  end
end
