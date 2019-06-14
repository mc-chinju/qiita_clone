# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  title      :string(255)
#  body       :text(65535)
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "rails_helper"

RSpec.describe Article, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
