class Admin::LightningTalksController < ApplicationController
  def new
    @lightning_talk = LightningTalk.new
    @days = Day.all
    @users = User.all
  end

  def create
    @lightning_talk = LightningTalk.new(lightning_talk_params)
    @days = Day.all
    @users = User.all
    if @lightning_talk.save
      flash[:notice] = "Lightning Talk Successfully Created"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def lightning_talk_params
    params.require(:lightning_talk).permit(:name, :day_id, :user_id)
  end
end
