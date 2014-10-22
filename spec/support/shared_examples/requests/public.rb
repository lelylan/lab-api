shared_examples_for 'a public listable resource' do

  let!(:not_owned) { FactoryGirl.create factory }

  it 'shows all resources (owned and not owned)' do
    get uri, {}, {}
    expect(response.status).to be(200)
    expect(JSON.parse(response.body).length).to eq(2)
  end
end

shared_examples_for 'a public resource' do |action|

  let!(:not_owned) { FactoryGirl.create factory }
  let(:uri)        { "/#{controller}/#{not_owned.id}" }

  it 'does not create a resource' do
    eval action
    expect(response.status).to eq(200)
  end
end
