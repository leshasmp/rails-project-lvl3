# frozen_string_literal: true

class AdminPolicy < ApplicationPolicy
  def index?
    admin?
  end

  private

  def admin?
    user&.admin?
  end
end
