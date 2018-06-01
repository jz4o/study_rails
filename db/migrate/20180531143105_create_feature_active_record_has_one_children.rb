class CreateFeatureActiveRecordHasOneChildren < ActiveRecord::Migration[5.2]
  def change
    create_table :feature_active_record_has_one_children do |t|
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
  end
end
