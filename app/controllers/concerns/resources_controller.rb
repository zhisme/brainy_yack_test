module ResourcesController
  extend ActiveSupport::Concern

  included do
    helper_method :item
    # rubocop:disable Rails/LexicallyScopedActionFilter
    before_action :set_item, only: %i[edit update show destroy]
    # rubocop:enable Rails/LexicallyScopedActionFilter
    #
  end

  module ClassMethods
    attr_writer :resource_class

    # Resource class for controller. Default to class, based on
    # demodulized controller name.
    def resource_class
      @resource_class ||=
        name.to_s.
          demodulize.
          sub(/Controller$/, '').
          singularize.
          constantize
    end
  end

  protected

  # Accesss resources collection.
  def collection
    @_collection ||= source_for_collection
  end

  def item
    @item
  end

  # End-point relation to be used as source for `collection`.
  def source_for_collection
    source_relation
  end

  # Relation which is used to find and build resources.
  def source_relation
    self.class.resource_class
  end

  # Resource found by `params[:id]`
  def set_item
    @item ||= source_relation.find params[:id]
  end

  # Instantiate resource with attrs from `resource_params`.
  def build_resource(attrs = resource_params)
    @item = source_relation.new(attrs)
  end

  def permit_params
    raise 'Implement permit_params!'
  end
end

