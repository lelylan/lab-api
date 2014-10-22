require 'spec_helper'

describe Project do

  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :link }

  describe 'when tagged' do

    let!(:resource) { FactoryGirl.create :project, tags: 'foo,bar' }

    it 'sets the tags' do
      expect(resource.tags_array).to eq(['foo', 'bar'])
    end

    describe 'when searching' do

      describe 'with a tag' do

        it 'gets the tagged resources' do
          expect(Project.all.tagged_with('foo').count).to eq(1)
        end
      end
    end
  end
end
