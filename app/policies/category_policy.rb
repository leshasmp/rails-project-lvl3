# frozen_string_literal: true

class CategoryPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def edit?
    admin?
  end

  def new?
    admin?
  end

  def create?
    admin?
  end

  def update?
    admin?
  end

  def destroy?
    admin?
  end

  private

  def admin?
    user&.admin?
  end
end
