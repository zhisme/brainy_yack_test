class Api::V1::BaseController < ApiController
  include ResourcesController

  def index
    render json: collection
  end

  def create
    build_resource

    if item.save
      render json: item
    else
      render json: item.errors, status: 422
    end
  end

  def show
    render json: item
  end

  def update
    if item.update(resource_params)
      yield(item) if block_given?

      render json: item
    else
      render json: item.errors, status: 422
    end
  end

  def destroy
    item.destroy

    yield(item) if block_given?

    render json: {}, status: 204
  end
end
