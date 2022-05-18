# frozen_string_literal: true

class ProfilePolicy < ApplicationPolicy
  def index?
    user
  end
end
