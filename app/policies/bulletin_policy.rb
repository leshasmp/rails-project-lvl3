# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    user
  end

  def show?
    record.published?
  end

  def new?
    user
  end

  def edit?
    admin? || user == record.user
  end

  def create?
    user
  end

  def to_moderation?
    admin? || user == record.user
  end

  def publish?
    admin?
  end

  def reject?
    admin?
  end

  def archive?
    admin? || user == record.user
  end

  def update?
    user
  end

  private

  def admin?
    user&.admin?
  end
end
