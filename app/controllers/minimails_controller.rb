class MinimailsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @minimail = Minimail.new(reciever_id: params[:reciever_id])
    @recieveUser = User.find(params[:reciever_id])
  end

  def create
    @minimail = current_user.send_minimails.build(minimail_params)
    if @minimail.save
      redirect_to minimail_path(current_user)
    else
      redirect_to root_url
    end
  end

  def destroy
    @minimail.destroy
    redirect_to minimail_path(current_user)
  end

  private

    def minimail_params
      params.require(:minimail).permit(:sender_id, :reciever_id, :title, :content, :reply_id)
    end
end
