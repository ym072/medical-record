class CreateDiseaseRecords < ActiveRecord::Migration[7.2]
  def change
    create_table :disease_records do |t|
      t.references :kid, null: false, foreign_key: true
      t.datetime :start_at
      t.datetime :end_at
      t.string :name

      t.timestamps
    end
  end
end
