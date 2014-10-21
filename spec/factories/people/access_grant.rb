FactoryGirl.define do
  factory :access_grant, class: Doorkeeper::AccessGrant do
    application
    resource_owner_id { BSON::ObjectId.new }
    redirect_uri 'https://example.org/callback'
    expires_in 100
    scopes 'user'
  end
end
