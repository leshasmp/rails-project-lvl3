# frozen_string_literal: true

class Web::HomeController < Web::ApplicationController
  def index
    @q = Bulletin.published.order('created_at DESC').ransack(params[:query])
    @bulletins = @q.result.page(params[:page])
  end
end
