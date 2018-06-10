FactoryBot.define do
  factory :feature_active_record_parent, class: 'FeatureActiveRecord::Parent' do
    sequence(:name) { |n| "test#{format('%04d', n)}" }

    factory :feature_active_record_parent_with_children do
      transient do
        has_many_children_size 5
      end

      after(:create) do |parent, transient|
        create :feature_active_record_has_one_child, parent: parent
        create_list :feature_active_record_has_many_child, transient.has_many_children_size, parent: parent
      end
    end
  end
end
