class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.belongs_to :organization, index: true
      t.timestamps null: false
    end
  end
end
