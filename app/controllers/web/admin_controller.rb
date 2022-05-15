# frozen_string_literal: true

class Web::AdminController < Web::ApplicationController
  def index
    @bulletins = Bulletin.all
  end
end
