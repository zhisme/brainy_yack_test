module SqlCommandDefiner
  extend self

  def search?(params)
    params[:term].present?
  end

  def sort?(params)
    params[:sort_by].present?
  end

  def group?(params)
    params[:group_by].present?
  end

  def group_by_story?(params)
    params[:group_by_story].present?
  end
end
