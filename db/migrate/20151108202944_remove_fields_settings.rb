class RemoveFieldsSettings < ActiveRecord::Migration
  def change
    remove_column :settings, :commits, :float
    remove_column :settings, :additions, :float
    remove_column :settings, :deletions, :float
  end
end
