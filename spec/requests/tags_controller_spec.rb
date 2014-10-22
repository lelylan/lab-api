#require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

#describe 'TagsController' do

  #let!(:application)  { FactoryGirl.create :application }
  #let!(:user)         { FactoryGirl.create :user }
  #let!(:access_token) { FactoryGirl.create :access_token, application: application, scopes: 'resources', resource_owner_id: user.id }

  #let(:auth_headers)  { {"Content-Type" => "application/json", 'Authorization' => "Bearer #{access_token.token}"} }

  #let(:controller) { 'projects' }
  #let(:factory)    { 'project'  }


  #describe 'GET /tags' do

    #before { FactoryGirl.create :project, resource_owner_id: user.id, tags: 'foo,bar' }
    #before { FactoryGirl.create :project, resource_owner_id: user.id, tags: 'bar,baz' }

    #it 'gets the tags list' do
      #get '/tags'

      #json = JSON.parse(response.body)
      #expect(json.length).to eq(3)

      #expect(json[0]['name']).to eq('bar')
      #expect(json[0]['count']).to eq(2)

      #expect(json[1]['name']).to eq('baz')
      #expect(json[1]['count']).to eq(1)

      #expect(json[2]['name']).to eq('foo')
      #expect(json[2]['count']).to eq(1)
    #end
  #end
#end
