require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

describe 'ProjectsController' do

  let!(:application)  { FactoryGirl.create :application }
  let!(:user)         { FactoryGirl.create :user }
  let!(:access_token) { FactoryGirl.create :access_token, application: application, scopes: 'resources', resource_owner_id: user.id }

  let(:auth_headers)  { {"Content-Type" => "application/json", 'Authorization' => "Bearer #{access_token.token}"} }

  let(:controller) { 'projects' }
  let(:factory)    { 'project'  }

  describe 'GET /projects' do

    let!(:resource) { FactoryGirl.create :project, resource_owner_id: user.id }
    let(:uri)       { '/projects' }

    it_behaves_like 'a listable resource'
    #it_behaves_like 'a paginable resource'
    #it_behaves_like 'a searchable resource', { name: 'My name is resource', category: 'locks' }
    #it_behaves_like 'a searchable resource on properties'
    #it_behaves_like 'a filterable list'
  end

  #describe '#image' do

    #let(:project) { FactoryGirl.create(:project) }
    #let(:image)   { Rack::Test::UploadedFile.new('spec/fixtures/images/example.png', 'image/png') }

    #before do
      #put "/projects/#{project.id}", {
          #image: {
            #content_type: image.content_type,
            #filename: image.original_filename,
            #file_data: Base64.encode64(image.read)
          #}
        #}.to_json, auth_headers
    #end

    #it 'returns the image URL' do
      #pp response.body
      #JSON.parse(response.body).should_not be_nil
    #end
  #end

end
