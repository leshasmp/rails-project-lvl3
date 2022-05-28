# frozen_string_literal: true

class ProfilesPolicy < ApplicationPolicy
  def show?
    user
  end
end
