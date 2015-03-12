class Admin::LightningTalksController < ApplicationController
  before_action :require_admin
  before_action :set_talk, only:[:show, :edit, :update]

  def index
    @lightning_talks = LightningTalk.all
  end

  def new
    @lightning_talk = LightningTalk.new
    @days = Day.where("talk_date >=?", Date.today).sort_by { |d| d.talk_date }
    @users = User.all.sort_by { |u| u.username.downcase }
  end

  def create
    lightning_talk = LightningTalk.new(lightning_talk_params)
    lightning_talk, success = LightningTalkManager.build(lightning_talk)
    if lightning_talk.save
      flash[:notice] = "Lightning Talk Successfully Created"
      redirect_to admin_lightning_talks_path
    else
      @days = Day.where("talk_date >=?", Date.today).sort_by { |d| d.talk_date }
      @users = User.all
      @lightning_talk = lightning_talk
      flash[:notice] = "Somethign went wrong"
      render :new
    end
  end

  def edit
    @days = Day.where("talk_date >=?", Date.today).sort_by { |d| d.talk_date }
    @users = User.all.sort_by { |u| u.username.downcase }
  end

  def update
    if @lightning_talk.update(lightning_talk_params)
      flash[:notice] = "Lightning Talk Successfully Updated"
      redirect_to admin_lightning_talks_path
    else
      @users = User.all
      @days = Day.where("talk_date >=?", Date.today).sort_by{ |d| d.talk_date }
      flash[:notice] = "Something went wrong"
      render :edit
    end
  end

  def destroy
    lightning_talk = LightningTalk.find(params[:id])
    lightning_talk, success = LightningTalkManager.unbuild(lightning_talk)
    flash[:notice] = "Lightning Talk successfully Deleted"
    redirect_to admin_lightning_talks_path
  end

  private

  def lightning_talk_params
    params.require(:lightning_talk).permit(:name, :day_id, :user_id)
  end

  def set_talk
    @lightning_talk = LightningTalk.find(params[:id])
  end

end
