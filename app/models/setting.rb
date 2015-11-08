class Setting < ActiveRecord::Base
  belongs_to :organization
  has_attached_file :file
end
