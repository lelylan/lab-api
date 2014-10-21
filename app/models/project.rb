class Project

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  # scopes

  scope :recent, -> { order_by(:updated_at.desc) }

  # fields

  field :resource_owner_id, type: BSON::ObjectId
  field :name
  field :description

  # image fields

  has_mongoid_attached_file :image, styles: {
    thumb: '100x100#',
    square: '200x200#',
    medium: '300x300#'
  }

  validates_attachment_content_type :image, content_type: ['image/jpeg', 'image/png']

  # validations

  validates :name, presence: true
  validates :description, presence: true

end
