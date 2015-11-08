class AddAttachementToSetting < ActiveRecord::Migration
  def change
    add_attachment :settings, :file
  end
end
