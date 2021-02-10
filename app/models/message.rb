class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_one_attached :image

  validates :content, presence: true, unless: :was_attached?
  # コンテントがなければ＝unless: :was_attached?
  def was_attached?
    self.image.attached?
    # self＝じぶん　画像ファイルがあればtrueを返して保存できるようにする
  end
end
