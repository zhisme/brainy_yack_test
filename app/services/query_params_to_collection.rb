class QueryParamsToCollection
  attr_reader :params, :collection

  def self.call(params, collection = Article.all)
    new(params, collection).call
  end

  def call
    Validator.call(params)
    @collection = CollectionBuilder.call(params, collection)

    success!
    self
  rescue StandardError
    failure!
    self
  end

  def success?
    success
  end

  private

  attr_reader :success

  def failure!
    @success = false
  end

  def success!
    @success = true
  end

  def initialize(params, collection)
    @params = params
    @collection = collection
    @success = false
  end
end
