class Api::V1::ArticlePreviewSerializer < ActiveModel::Serializer
  attributes :id, :title
  belongs_to :user
end
