class FeatureActiveRecord::Parent < ApplicationRecord
  has_one :has_one_child, dependent: :destroy
  accepts_nested_attributes_for :has_one_child
end
