shared_examples_for 'a searchable resource' do |searchable|

  searchable.each do |key, value|

    describe "?#{key}=:#{key}" do

      let!(:result) { FactoryGirl.create factory, key => value, resource_owner_id: user.id }
      # HACK - the category is inherited and overridden by the type
      before { result.update_attributes(category: value) if key == :category }

      it 'returns the searched resource' do
        value = value.first if value.is_a? Array
        page.driver.get uri, key => value
        contains_resource result
        page.should_not have_content resource.id.to_s
      end
    end
  end
end

shared_examples_for 'a searchable resource on properties' do

  let!(:result) { FactoryGirl.create factory, resource_owner_id: user.id }

  context 'when filters the property uri' do

    let(:properties)   { { id: result.properties.first.property_id } }

    it 'returns the searched resource' do
      page.driver.get uri, properties: properties
      contains_resource result
      page.should_not have_content resource.id.to_s
    end
  end

  context 'when filters #value' do

    before { result.properties.first.update_attributes(value: 'updated') }
    let(:properties) { { value: 'updated' } }

    it 'returns the searched resource' do
      page.driver.get uri, properties: properties
      contains_resource result
      page.should_not have_content resource.id.to_s
    end
  end

  context 'when filters #expected' do

    before { result.properties.first.update_attributes(expected: 'updated') }
    let(:properties) { { expected: 'updated' } }

    it 'returns the searched resource' do
      page.driver.get uri, properties: properties
      contains_resource result
      page.should_not have_content resource.id.to_s
    end
  end

  context 'when filters #pending' do

    before { result.properties.first.update_attributes(pending: true) }
    let(:properties) { { pending: true } }

    it 'returns the searched resource' do
      page.driver.get uri, properties: properties
      contains_resource result
      page.should_not have_content resource.id.to_s
    end
  end

  context 'when filters #uri, #value, #expected, #pending' do

    let(:property_uri) { a_uri(result.properties.first, :property_id) }
    let(:properties)   { { uri: property_uri, value: 'updated', expected: 'updated', pending: false } }

    before { result.properties.first.update_attributes(value: 'updated', expected: 'updated', pending: false) }

    it 'returns the searched resource' do
      page.driver.get uri, properties: properties
      contains_resource result
      page.should_not have_content resource.id.to_s
    end
  end
end

shared_examples_for 'a searchable resource on timing' do |field|

  let(:value)   { Time.now - 3600 }
  let!(:result) { FactoryGirl.create factory, resource_owner_id: user.id }

  context '?from={Time.now-60}' do

    before     { resource.update_attributes(field => value) }
    let(:from) { Time.now - 60 }

    it 'returns the searched resource' do
      page.driver.get uri, from: from
      contains_resource result
      page.should_not have_content resource.id.to_s
    end
  end

  context '?to={Time.now-60}' do

    before   { result.update_attributes(field => value) }
    let(:to) { Time.now - 60 }

    it 'returns the searched resource' do
      page.driver.get uri, to: to
      contains_resource result
      page.should_not have_content resource.id.to_s
    end
  end
end
