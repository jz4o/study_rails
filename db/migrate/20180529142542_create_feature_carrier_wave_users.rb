class CreateFeatureCarrierWaveUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :feature_carrier_wave_users do |t|
      t.string :name
      t.string :avatar

      t.timestamps
    end
  end
end
