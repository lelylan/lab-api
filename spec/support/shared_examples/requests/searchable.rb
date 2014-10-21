shared_examples_for 'a searchable resource' do |searchable|

  searchable.each do |key, value|

    describe "?#{key}=:#{key}" do

      let!(:result) { FactoryGirl.create factory, key => value, resource_owner_id: user.id }

      it 'returns the searched resource' do
        value = value.first if value.is_a? Array
        get uri, {key => value}, auth_headers
        contains_resource result
        expect(response.body).to_not match(resource.id.to_s)
      end
    end
  end
end
