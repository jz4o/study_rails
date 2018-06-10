require 'rails_helper'

RSpec.describe FeatureActiveRecord::Parent, type: :model do
  describe 'relations' do
    it { should have_one(:has_one_child).dependent(:destroy) }
    it { should have_many(:has_many_children).dependent(:destroy) }
  end

  describe 'nested attributes' do
    it { should accept_nested_attributes_for(:has_one_child).allow_destroy(true) }
    it { should accept_nested_attributes_for(:has_many_children).allow_destroy(true) }
  end
end
