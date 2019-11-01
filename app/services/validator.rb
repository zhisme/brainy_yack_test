module Validator
  extend self

  class Error < StandardError; end
  class QueryParamsInvalid < Error; end

  def call(params)
    if SqlCommandDefiner.search?(params) ^ SqlCommandDefiner.sort?(params) ^
       SqlCommandDefiner.group?(params) ^ SqlCommandDefiner.group_by_story?(params)

      return if SqlCommandDefiner.search?(params)

      return AttrValidator.call(params)
    end

    raise QueryParamsInvalid
  end
end
