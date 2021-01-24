class MinimailsController < ApplicationController
  before_action :authenticate_user!

  def show
    @minimail = Minimail.find_by(id: params[:id])
    if @minimail.reciever_id == current_user.id
      @minimail.update_attributes(checked: true)
    end
  end

  def new
    @minimail = Minimail.new(reciever_id: params[:reciever_id])
    @recieve_user = User.find(params[:reciever_id])
  end

  def create
    @minimail = current_user.send_minimails.build(minimail_params)
    if @minimail.save
      redirect_to sended_user_path(current_user)
    else
      recieve_user = User.find_by(id: params[:minimail][:reciever_id])
      redirect_to new_minimail_path(reciever_id: recieve_user.id)
    end
  end

  def destroy
    @minimail.destroy
    redirect_to minimail_path(current_user)
  end

  private

  def minimail_params
    params.require(:minimail).permit(:sender_id, :reciever_id, :title, :content)
  end
end
