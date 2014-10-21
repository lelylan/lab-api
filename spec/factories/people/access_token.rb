FactoryGirl.define do
  factory :access_token, class: Doorkeeper::AccessToken do
    application
    resource_owner_id { Moped::BSON::ObjectId.new }
    expires_in 7200
    scopes 'user'
  end
end
