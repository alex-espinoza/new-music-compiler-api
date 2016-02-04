class AddSoundcloudIdToSources < ActiveRecord::Migration
  def change
    add_column :sources, :soundcloud_id, :string
  end
end
