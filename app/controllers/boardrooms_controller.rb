class BoardroomsController < ApplicationController
  def show
    @boardroom = Boardroom.find(params[:id])
    @chats = @boardroom.chats
  end

  def create
    @boardroom = Boardroom.new(boardroom_params)
    @boardroom.save
    current_user.user_boardrooms.create(boardroom_id: @boardroom.id)
    redirect_to boardroom_path(@boardroom)
  end

  private

    def boardroom_params
      params.require(:boardroom).permit(:article_id)
    end
end
