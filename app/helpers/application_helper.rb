# frozen_string_literal: true

module ApplicationHelper
  def state_collection
    collection = []
    states = Bulletin.aasm.states.map(&:name)
    states.each do |state|
      collection << [t("web.state.#{state}"), state]
    end
    collection
  end
end
