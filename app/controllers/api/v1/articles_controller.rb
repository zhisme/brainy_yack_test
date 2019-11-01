class Api::V1::ArticlesController < Api::V1::BaseController
  def index
    return render json: Article.order(id: :asc) if query_params.blank?

    result = QueryParamsToCollection.call(query_params)

    if result.success?
      render json: result.collection
    else
      render json: {}, status: 422
    end
  end

  def create
    build_resource

    item.story = Story.find(Story.pluck(:id).sample)

    if item.save
      ActionCable.server.broadcast 'ArticlesChannel', action: :create, data: item.as_json
      render json: item
    else
      render json: item.errors, status: 422
    end
  end

  def update
    super do |item|
      ActionCable.server.broadcast 'ArticlesChannel', action: :update, data: item.as_json
    end
  end

  def destroy
    super do |item|
      ActionCable.server.broadcast 'ArticlesChannel', action: :destroy, data: item.as_json
    end
  end

  private

  def query_params
    params.permit(:sort_direction, :sort_by, :group_by, :term, :group_by_story)
  end

  def resource_params
    params.require(:article).permit(:name, :text, :kind)
  end
end
