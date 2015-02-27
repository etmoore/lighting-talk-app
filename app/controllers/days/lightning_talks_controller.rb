class Days::LightningTalksController < ApplicationController
  def index
    @day = Day.find(params[:day_id])
    @lightning_talks = @day.lightning_talks
  end
end
