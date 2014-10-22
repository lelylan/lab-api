class TagsController < ApplicationController

  def index
    @tags = Project.tags_with_weight
    @tags = @tags.map { |tag| { name: tag.first, count: tag.last.to_i } }
    render json: @tags
  end
end

