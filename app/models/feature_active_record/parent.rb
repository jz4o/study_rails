class FeatureActiveRecord::Parent < ApplicationRecord
  has_one :has_one_child, dependent: :destroy
  accepts_nested_attributes_for :has_one_child, allow_destroy: true

  has_many :has_many_children, dependent: :destroy
  accepts_nested_attributes_for :has_many_children, allow_destroy: true
end
