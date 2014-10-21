class ApplicationSerializer < ActiveModel::Serializer
	attributes :id, :created_at, :updated_at

	def created_at
  	object.created_at.utc 
  end

  def updated_at
  	object.updated_at.utc 
  end
 
  def id
    object.id.to_s
  end
end
