require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

describe 'ProjectsController' do

  let!(:application)  { FactoryGirl.create :application }
  let!(:user)         { FactoryGirl.create :user }
  let!(:access_token) { FactoryGirl.create :access_token, application: application, scopes: 'resources', resource_owner_id: user.id }

  let(:auth_headers)  { {"Content-Type" => "application/json", 'Authorization' => "Bearer #{access_token.token}"} }

  let(:controller) { 'projects' }
  let(:factory)    { 'project'  }


  context 'GET /projects/public' do

    let!(:resource) { FactoryGirl.create :project, resource_owner_id: user.id }
    let(:uri)       { '/projects/public' }

    it_behaves_like 'a public listable resource'
    it_behaves_like 'a paginable resource'
    #it_behaves_like 'a orderable resource'
    it_behaves_like 'a searchable resource', { name: 'Alice', description: 'Alice' }
  end


  describe 'GET /projects' do

    let!(:resource) { FactoryGirl.create :project, resource_owner_id: user.id }
    let(:uri)       { '/projects' }

    it_behaves_like 'a listable resource'
    it_behaves_like 'a paginable resource'
    it_behaves_like 'a searchable resource', { name: 'Alice', description: 'Alice' }
  end


  #context 'GET /projects/:id' do

    #let!(:resource) { FactoryGirl.create :project, resource_owner_id: user.id }
    #let(:uri)       { "/projects/#{resource.id}" }


    #it_behaves_like 'a showable resource'
    #it_behaves_like 'a public resource',    'get(uri, {}, auth_headers)'
    #it_behaves_like 'a not found resource', 'get(uri, {}, auth_headers)'
    ##it_behaves_like 'a not owned resource', 'get(uri, {}, auth_headers)'
  #end


  #context 'POST /projects' do

    #let(:uri)     { '/projects' }
    #let(:project) { FactoryGirl.create 'project' }
    #let(:image)   { Rack::Test::UploadedFile.new('spec/fixtures/images/example.png', 'image/png') }

    #let(:params) { {
      #name: 'Name',
      #description: 'Description',
      #link: 'http://example.com',
      #image_data: Base64.encode64(image.read),
      #content_type: image.content_type,
      #original_filename: image.original_filename
    #} }

    #describe 'with image' do
      #before { post uri, params.to_json, auth_headers }
      #let(:resource) { Project.last }

      #it_behaves_like 'a creatable resource'
      #it_behaves_like 'a validated resource', 'post(uri, {}.to_json, auth_headers)', { method: 'POST', error: 'can\'t be blank' }

      #it 'saves the image' do
        #expect(resource.image.url).to match('s3_domain_url')
      #end
    #end

    #describe 'with no image' do
      #before { post uri, { name: 'Name', description: 'Description', link: 'http://example.com' }.to_json, auth_headers }
      #let(:resource) { Project.last }

      #it 'sets the default image' do
        #expect(resource.image.url).to match('missing')
      #end
    #end
  #end


  #context 'PUT /projects/:id' do

    #let!(:resource) { FactoryGirl.create :project, resource_owner_id: user.id }
    #let(:uri)       { "/projects/#{resource.id}" }
    #let(:params)    { { name: 'updated' } }

    #it_behaves_like 'an updatable resource'
    #it_behaves_like 'a not owned resource', 'put(uri, {}, auth_headers)'
    #it_behaves_like 'a not found resource', 'put(uri, {}, auth_headers)'
    #it_behaves_like 'a validated resource', 'put(uri, { name: "" }.to_json, auth_headers)', { method: 'PUT', error: 'can\'t be blank' }
  #end


  #context 'DELETE /projects/:id' do
    #let!(:resource) { FactoryGirl.create :project, resource_owner_id: user.id }
    #let(:uri)       { "/projects/#{resource.id}" }

    #it_behaves_like 'a deletable resource'
    #it_behaves_like 'a not owned resource', 'delete(uri, {}, auth_headers)'
    #it_behaves_like 'a not found resource', 'delete(uri, {}, auth_headers)'
  #end
end
