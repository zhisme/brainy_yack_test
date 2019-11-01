class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.string :name, null: false
      t.integer :articles_kind_count, default: 0
      t.integer :articles_count, default: 0

      t.timestamps
    end

    add_index :stories, :name, unique: true
  end
end
