FactoryBot.define do
  factory :feature_active_record_has_many_child, class: 'FeatureActiveRecord::HasManyChild' do
    sequence(:name) { |n| "test#{format('%04d', n)}" }
    association :parent, factory: :feature_active_record_parent
  end
end
