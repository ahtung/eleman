require 'rails_helper'

RSpec.describe Setting, type: :model do
  it { should have_attached_file(:file) }
  it { should validate_attachment_presence(:file) }
  it { should validate_attachment_content_type(:file).allowing("text/yaml").rejecting("application/pdf") }
  it { should validate_attachment_size(:file).less_than(10.megabytes) }
end
