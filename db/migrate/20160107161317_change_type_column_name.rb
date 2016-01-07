class ChangeTypeColumnName < ActiveRecord::Migration
  def change
  	rename_column :sources, :type, :parser_format
  end
end
