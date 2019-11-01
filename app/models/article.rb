class Article < ApplicationRecord
  belongs_to :story, counter_cache: true

  enum kind: %i[twitter facebook blog]

  validates :name, :kind, :story, presence: true

  after_save :recalculate_kind_count

  private

  def recalculate_kind_count
    kind_count = story.articles.pluck(:kind).uniq.size

    return if story.articles_kind_count == kind_count

    story.update(articles_kind_count: kind_count)
  end
end
