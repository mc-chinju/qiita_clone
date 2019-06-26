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
#  status     :string(255)      default("draft")
#

FactoryBot.define do
  factory :article do
    title { Faker::Lorem.word }
    body { Faker::Lorem.sentence }
    status { :published }
    user

    trait :draft do
      status { :draft }
    end

    trait :published do
      status { :published }
    end
  end
end
