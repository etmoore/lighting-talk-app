class Admin::LightningTalksController < ApplicationController
  before_action :require_admin

  def new
    @lightning_talk = LightningTalk.new
    @days = Day.all.sort_by { |d| d.talk_date }
    @users = User.all.sort_by { |u| u.username.downcase }
  end

  def create
    lightning_talk = LightningTalk.new(lightning_talk_params)
    lightning_talk, success = LightningTalkManager.build(lightning_talk)
    @days = Day.all
    @users = User.all
    if lightning_talk.save
      flash[:notice] = "Lightning Talk Successfully Created"
      redirect_to root_path
    else
      @lightning_talk = lightning_talk
      render :new
    end
  end

  private

  def lightning_talk_params
    params.require(:lightning_talk).permit(:name, :day_id, :user_id)
  end

  def require_admin
    redirect_to root_path, notice: "You don't have permission to access that page" unless current_user && current_user.admin
  end
end
