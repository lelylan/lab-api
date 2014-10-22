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

      it 'gets the tagged resources' do
        expect(Project.all.tagged_with('foo').count).to eq(1)
      end
    end

    describe 'with multiple resources' do

      before { FactoryGirl.create :project, tags: 'bar,baz' }

      it 'gets the weight tags' do
        expect(Project.tags_with_weight).to eq([['bar', 2.0], ['baz', 1.0], ['foo', 1.0]])
      end
    end
  end
end
