class Setting < ActiveRecord::Base
  belongs_to :organization
  has_attached_file :file
  validates_attachment :file, presence: true,
    content_type: { content_type: "text/yaml" },
    size: { in: 0..10.megabytes }
end
