# frozen_string_literal: true

module AdminHelper
  def current_class?(test_path)
    if request.path == test_path
      'nav-link link-dark active'
    else
      'nav-link link-dark'
    end
  end
end
