class Setting < ActiveRecord::Base
  belongs_to :organization
  has_attached_file :file
  validates_attachment :file, presence: true,
    content_type: { content_type: ['text/yaml', 'text/x-yaml'] },
    size: { in: 0..10.megabytes }

  def contents
    Paperclip.io_adapters.for(file).read
  end

  def commit_rate
    yaml['settings']['commits'].to_f
  end

  def addition_rate
    yaml['settings']['additions'].to_f
  end

  def deletion_rate
    yaml['settings']['deletions'].to_f
  end

  def yaml
    YAML::load(contents).to_hash
  end
end