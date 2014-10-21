FactoryGirl.define do
  factory :application, class: Doorkeeper::Application do
    redirect_uri 'http://example.org'
    name 'example'
  end
end
