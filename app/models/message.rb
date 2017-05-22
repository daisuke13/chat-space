class Message < ApplicationRecord
  validates :body_or_image, presence: true

  mount_uploader :image, ImageUploader

  belongs_to :user
  belongs_to :group

  private
    def body_or_image
      body.presence or image.presence
    end
end
