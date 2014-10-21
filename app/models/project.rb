class Project
  include Mongoid::Document
  include Mongoid::Timestamps

  scope :recent, -> { order_by(:updated_at.desc) }

  field :name

  validates :name, presence: true
end
