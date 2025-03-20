# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def active_class(*paths)
    'active' if paths.any? { |path| request.path.start_with?(path) }
  end
end
