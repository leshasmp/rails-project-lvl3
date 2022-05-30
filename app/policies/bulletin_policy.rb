# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def show?
    admin? || author? || record.published?
  end

  def new?
    user
  end

  def edit?
    admin? || author?
  end

  def create?
    user
  end

  def to_moderation?
    admin? || author?
  end

  def archive?
    admin? || author?
  end

  def update?
    user
  end

  private

  def author?
    user == record.user
  end

  def admin?
    user&.admin?
  end
end
