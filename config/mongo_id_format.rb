module BSON
  class ObjectId
    alias_method :to_json, :to_s
    alias_method :as_json, :to_s
  end
end
