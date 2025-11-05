class CreateKids < ActiveRecord::Migration[7.2]
  def change
    create_table :kids do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.date :birthday

      t.timestamps
    end
  end
end
