shared_examples_for 'a orderable resource' do |ordable|

  ordable.each do |key|

    describe "order=:#{key}" do

      let!(:first) { FactoryGirl.create :project, resource_owner_id: user.id, key => 1 }

      it 'returns the searched resource' do
        get uri, {order: key}, auth_headers
        contains_resource first
      end
    end
  end
end
