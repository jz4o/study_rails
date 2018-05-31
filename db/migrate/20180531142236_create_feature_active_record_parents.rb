class CreateFeatureActiveRecordParents < ActiveRecord::Migration[5.2]
  def change
    create_table :feature_active_record_parents do |t|
      t.string :name

      t.timestamps
    end
  end
end
