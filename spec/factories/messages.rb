FactoryBot.define do
  factory :message do
    content {Faker::Lorem.sentence}
    association :user
    association :room
    after(:build) do |message|
      # after(:build)＝FactoryBotでダミーが生成されたあと
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
      # message.image.attach＝メッセージに画像を添付する
    end
  end
end

