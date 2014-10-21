require 'spec_helper'

describe Doorkeeper::Application do

  let(:application) { FactoryGirl.create :application }

  it 'connects to people database' do
    expect(Doorkeeper::Application.database_name).to be(:people_test)
  end

  it 'creates an application' do
    expect(application.id).to_not be_nil
  end
end
