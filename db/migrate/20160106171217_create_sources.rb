class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :name
      t.string :type
      t.string :url
      t.timestamp :last_checked_at

      t.timestamps null: false
    end
  end
end
