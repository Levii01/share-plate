# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def active_class(path)
    'active' if current_page?(path)
  end
end
