class FeatureCarrierWave::User < ApplicationRecord
  mount_uploader :avatar, FileUploader
end
