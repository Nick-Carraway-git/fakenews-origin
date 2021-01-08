class BoardroomsController < ApplicationController
  def show
    @boardroom = Boardroom.find(params[:id])
  end

  def create
    @boardroom = Boardroom.new(boardroom_params)
    @boardroom.save
    current_user.user_boardrooms.create(boardroom_id: @boardroom.id)
    redirect_to root_url
  end

  private

    def boardroom_params
      params.require(:boardroom).permit(:article_id)
    end
end
