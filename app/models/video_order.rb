class VideoOrder < ApplicationRecord

  mount_uploader :video, VideoUploader
  serialize :video, JSON

  belongs_to :order

  validates :order_id, uniqueness: true

end
