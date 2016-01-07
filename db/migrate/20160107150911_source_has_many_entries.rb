class SourceHasManyEntries < ActiveRecord::Migration
  def change
  	add_reference :entries, :source, index: true, foreign_key: true
  end
end
