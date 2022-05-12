# frozen_string_literal: true

class Web::HomeController < Web::ApplicationController
  def index
    @bulletins = Bulletin.all.order('created_at DESC')
  end
end
