class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :name
      t.text :content
      t.references :page, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
