require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

describe 'Scope' do

  let!(:application) { FactoryGirl.create :application }
  let!(:user) { FactoryGirl.create :user }

  describe 'with no access token' do

    let(:project) { FactoryGirl.create :project, resource_owner_id: user.id }

    it { get    '/projects/public';        expect(response.status).to_not eq(401) }
    it { get    "/projects/#{project.id}"; expect(response.status).to_not eq(401) }
    it { get    '/projects';               expect(response.status).to eq(401) }
    it { post   '/projects';               expect(response.status).to eq(401) }
    it { put    "/projects/#{project.id}"; expect(response.status).to eq(401) }
    it { delete "/projects/#{project.id}"; expect(response.status).to eq(401) }

  end

  %w(user).each do |scope|

    context "with token #{scope}" do

      let!(:access_token) { FactoryGirl.create :access_token, scopes: scope, resource_owner_id: user.id }
      let(:auth_headers)  { {"Content-Type" => "application/json", 'Authorization' => "Bearer #{access_token.token}"} }

      let(:project) { FactoryGirl.create :project, resource_owner_id: user.id }

      it { get    '/projects/public', {}, auth_headers;        expect(response.status).to_not eq(401) }
      it { get    "/projects/#{project.id}", {}, auth_headers; expect(response.status).to_not eq(401) }
      it { get    '/projects', {}, auth_headers;               expect(response.status).to_not eq(401) }
      it { post   '/projects', {}, auth_headers;               expect(response.status).to_not eq(401) }
      it { put    "/projects/#{project.id}", {}, auth_headers; expect(response.status).to_not eq(401) }
      it { delete "/projects/#{project.id}", {}, auth_headers; expect(response.status).to_not eq(401) }

    end
  end
end
