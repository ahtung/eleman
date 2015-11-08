class AddFieldsToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :commits, :float
    add_column :settings, :additions, :float
    add_column :settings, :deletions, :float
  end
end
