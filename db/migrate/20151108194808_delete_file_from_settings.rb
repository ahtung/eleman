class DeleteFileFromSettings < ActiveRecord::Migration
  def change
    remove_attachment :settings, :file
  end
end
