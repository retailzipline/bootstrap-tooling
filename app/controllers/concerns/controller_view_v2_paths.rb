# Make it easy to annotate controller actions as being ready for v2 views
# Usage:
# class UserController < ActionController::Base
#   v2_ready :index  # will use views_v2.application if not specified
#   v2_ready :show, flag: 'other-flag-for-feature'
# end
module ControllerViewV2Paths
  extend ActiveSupport::Concern

  included do
    class_attribute :view_v2_paths
    self.view_v2_paths = [ActionView::OptimizedFileSystemResolver.new('app/views_v2')]
  end

  class_methods do
    def v2_ready(*action_names)
      options = action_names.extract_options!

      if action_names.present?
        before_action -> { prepend_v2_view_path(options) }, only: action_names
      else
        before_action :prepend_v2_view_path
      end
    end
  end

  def prepend_v2_view_path(options = {})
    flag = options[:flag].presence || 'views_v2.application'
    return unless defined?(user_context) && user_context.features.enabled?(flag)

    return if params.key?(:bs3)

    prepend_view_path OptimizedFileSystemResolverWithoutArea.new('app/views_v2')

    view_v2_paths.each { |resolver_path| prepend_view_path(resolver_path) }
  end
end
