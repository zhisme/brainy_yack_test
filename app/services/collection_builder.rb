class CollectionBuilder
  attr_reader :params, :collection

  DEFAULT_SORT_DIR = :desc

  class CollectionNotBuilded < StandardError; end

  def self.call(params, collection)
    new(params, collection).call
  end

  def call
    return search if SqlCommandDefiner.search?(params)
    return sort if SqlCommandDefiner.sort?(params)
    return group if SqlCommandDefiner.group?(params)
    return group_by_story if SqlCommandDefiner.group_by_story?(params)

    raise CollectionNotBuilded
  end

  private

  def initialize(params, collection)
    @params = params
    @collection = collection
  end

  def search
    collection.where('LOWER(name) LIKE :term OR LOWER(text) LIKE :term', term: "%#{params[:term].downcase}%")
  end

  def sort
    sort_by = params[:sort_by].to_s
    sort_direction = params[:sort_direction].to_s.presence || DEFAULT_SORT_DIR

    collection.order(sort_by => sort_direction)
  end

  def group
    collection.group_by { |ar| ar[params[:group_by]].to_s }
  end

  def group_by_story
    return group_by_story_articles_count if params[:group_by_story] == 'articles_count'

    group_by_story_articles_kind_count
  end

  def group_by_story_articles_count
    Story.includes(:articles).order(articles_count: :desc).map(&:articles)
  end

  def group_by_story_articles_kind_count
    Story.includes(:articles).order(articles_kind_count: :desc).map(&:articles)
  end
end
