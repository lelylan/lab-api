shared_examples_for 'a listable resource' do

  let!(:not_owned) { FactoryGirl.create factory }

  it 'shows all owned resources' do
    get uri, {}, auth_headers
    expect(response.status).to eq(200)
    contains_owned_resource resource
    does_not_contain_resource not_owned
  end
end

shared_examples_for 'a showable resource' do

  it 'view the owned resource' do
    get uri, {}, auth_headers
    expect(response.status).to eq(200)
    has_resource resource
  end
end

shared_examples_for 'a creatable resource' do

  let(:klass)    { controller.classify.constantize }

  it 'creates the resource' do
    post uri, params.to_json, auth_headers
    resource = klass.last
    expect(response.status).to eq(201)
    has_resource resource
  end

  it 'stores the resource' do
    expect { post(uri, params.to_json, auth_headers) }.to change { klass.count }.by(1)
  end
end

shared_examples_for 'an updatable resource' do

  it 'updates the resource' do
    put uri, params.to_json, auth_headers
    resource.reload
    expect(response.status).to eq(200)
    expect(response.body).to match('updated')
    has_resource resource
  end
end


shared_examples_for 'a deletable resource' do

  let(:klass)    { controller.classify.constantize }

  it 'deletes the resource' do
    expect { delete(uri, {}, auth_headers) }.to change{ klass.count }.by(-1)
    expect(response.status).to be(200)
    has_resource resource
  end
end
