# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  before_action :authenticate_user!, except: %i[show]

  def show
    @bulletin = Bulletin.find params[:id]
  end

  def new
    @bulletin = Bulletin.new
  end

  def edit
    @bulletin = Bulletin.find params[:id]
  end

  def create
    @bulletin = current_user.bulletins.new(bulletin_params)

    if @bulletin.save
      redirect_to root_path, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @bulletin = Bulletin.find params[:id]

    if @bulletin.update(bulletin_params)
      redirect_to @bulletin, notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bulletin = Bulletin.find params[:id]

    @bulletin.destroy

    redirect_to bulletins_url, notice: t('.success')
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :image, :category_id)
  end
end
