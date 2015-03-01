class Users::LightningTalksController < ApplicationController
  before_action :set_user

  def index
    @lightning_talks = @user.lightning_talks
  end

  def new
    @lightning_talk = LightningTalk.new
    @days = Day.all
  end

  def show
    @lighting_talk = LightningTalk.find(params[:id])
  end

  def create
    @lightning_talk = @user.lightning_talks.new(lightning_talk_params)
    @days = Day.all
    if @lightning_talk.save
      flash[:notice] = "Thanks for signing up for a lightning talk!"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def lightning_talk_params
    params.require(:lightning_talk).permit(:name, :day_id)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
