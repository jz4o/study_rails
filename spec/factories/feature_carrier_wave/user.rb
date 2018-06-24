FactoryBot.define do
  factory :feature_carrier_wave_user, class: 'FeatureCarrierWave::User' do
    sequence(:name) { |n| "test#{format('%04d', n)}" }
    avatar { File.open Rails.root.join('spec', 'factories', 'feature_carrier_wave', 'avatar_blue.png') }
  end
end
