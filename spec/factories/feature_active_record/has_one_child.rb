FactoryBot.define do
  factory :feature_active_record_has_one_child, class: 'FeatureActiveRecord::HasOneChild' do
    sequence(:name) { |n| "test#{format('%04d', n)}" }
    association :parent, factory: :feature_active_record_parent
  end
end
