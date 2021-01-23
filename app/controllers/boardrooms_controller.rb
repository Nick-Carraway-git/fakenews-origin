class BoardroomsController < ApplicationController
  before_action :authenticate_user!

  def show
    @boardroom = Boardroom.find_by(id: params[:id])
    unless @boardroom.blank?
      @chats = @boardroom.chats
    else
      redirect_to root_path
    end    
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
