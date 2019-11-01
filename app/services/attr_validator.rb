module AttrValidator
  extend self

  class AttrNotExist < Validator::Error; end
  class AttrValueInvalid < Validator::Error; end

  PERMITTED_ATTRS = Article.attribute_names.freeze
  STORY_PERMITTED_ATTRS = %w[articles_count articles_kind_count].freeze
  SORT_DIRECTION = %w[asc desc].freeze

  def call(params)
    if SqlCommandDefiner.sort?(params)
      if params[:sort_direction].present?
        validate_permitted(params[:sort_direction], SORT_DIRECTION)
      end

      return validate_permitted(params[:sort_by])
    end

    return validate_permitted(params[:group_by]) if SqlCommandDefiner.group?(params)
    return validate_group_by_story(params) if SqlCommandDefiner.group_by_story?(params)

    raise AttrNotExist
  end

  private

  def validate_group_by_story(params)
    return if STORY_PERMITTED_ATTRS.include?(params[:group_by_story])

    raise AttrValueInvalid
  end

  def validate_permitted(param, permitted_attr_names = PERMITTED_ATTRS)
    return if permitted_attr_names.include?(param)

    raise AttrValueInvalid
  end
end
