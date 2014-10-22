class Project

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include Mongoid::Taggable

  # callbacks

  before_save :decode_base64_image

  # scopes

  scope :recent, -> { order_by(:updated_at.desc) }

  # attr accessor

  attr_accessor :content_type, :original_filename, :image_data

  # fields

  field :resource_owner_id, type: BSON::ObjectId
  field :name
  field :description
  field :link
  field :views, type: Integer, default: 0
  field :likes, type: Integer, default: 0

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
  validates :link, presence: true

  protected

  def decode_base64_image
    if image_data && content_type && original_filename
      decoded_data = Base64.decode64(image_data)

      data = StringIO.new(decoded_data)
      data.class_eval do
        attr_accessor :content_type, :original_filename
      end

      data.content_type = content_type
      data.original_filename = File.basename(original_filename)

      self.image = data
    end
  end
end
