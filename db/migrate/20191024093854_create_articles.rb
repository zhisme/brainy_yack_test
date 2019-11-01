class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :name, null: false
      t.text :text, default: ''
      t.integer :kind, null: false, default: 0
      t.integer :story_id, null: false

      t.timestamps
    end

    add_index :articles, :name, unique: true
    add_index :articles, :text
  end
end
