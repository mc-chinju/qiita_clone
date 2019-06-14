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

class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :article_likes, dependent: :destroy
end
