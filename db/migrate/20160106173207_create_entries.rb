class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.text :description
      t.string :embed_data
      t.string :url
      t.timestamp :published_at

      t.timestamps null: false
    end
  end
end
