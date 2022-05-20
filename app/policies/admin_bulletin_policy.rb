# frozen_string_literal: true

class AdminBulletinPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def publish?
    admin?
  end

  def reject?
    admin?
  end

  def archive?
    admin?
  end

  private

  def admin?
    user&.admin?
  end
end
