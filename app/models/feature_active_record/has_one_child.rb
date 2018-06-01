class FeatureActiveRecord::HasOneChild < ApplicationRecord
  belongs_to :parent
end
