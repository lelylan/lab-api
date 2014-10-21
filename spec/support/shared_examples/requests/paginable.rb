shared_examples_for 'a paginable resource' do

  before { Settings.pagination.per = 1 }
  before { Settings.pagination.max_per = 2 }

  let(:decorator)  { "#{controller.classify}Decorator".constantize }

  let!(:resource)  { FactoryGirl.create(factory, resource_owner_id: user.id) }
  let!(:resources) { FactoryGirl.create_list(factory, Settings.pagination.per + 1, resource_owner_id: user.id) }

  describe '?start=:id' do

    it 'shows the next page' do
      get uri, {start: resource.id}, auth_headers
      expect(response.status).to eq(200)
      contains_resource resources.last
      expect(response.body).to_not match(resource.id.to_s)
    end
  end

  describe '?per=:nil' do

    it 'shows the default number of resources' do
      get uri, {}, auth_headers
      expect(JSON.parse(response.body).length).to be(Settings.pagination.per)
    end
  end

  describe '?per=1' do

    it 'shows 1 resource' do
      get uri, {per: 1}, auth_headers
      expect(JSON.parse(response.body).length).to be(1)
    end
  end

  context '?per=100000' do

    it 'shows the max number of allowed resources' do
      get uri, {per: 100000}, auth_headers
      expect(JSON.parse(response.body).length).to be(Settings.pagination.max_per)
    end
  end

  context '?per=not-valid' do

    it 'shows the default number of resources' do
      get uri, {per: 'not-valid'}, auth_headers
      expect(JSON.parse(response.body).length).to be(Settings.pagination.per)
    end
  end
end
