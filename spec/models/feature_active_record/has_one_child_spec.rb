require 'rails_helper'

RSpec.describe FeatureActiveRecord::HasOneChild, type: :model do
  describe 'relations' do
    it { should belong_to(:parent) }
  end
end
