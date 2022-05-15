# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  attr_reader :user, :bulletin

  def index?
    user
  end

  def new?
    user
  end

  def create?
    user
  end

  def update?
    admin? || user == record.author
  end

  private

  def admin?
    user&.admin?
  end
end
