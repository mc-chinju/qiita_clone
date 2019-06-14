# == Schema Information
#
# Table name: article_likes
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  article_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ArticleLike < ApplicationRecord
  belongs_to :user
  belongs_to :article
end
