class StaticPagesController < ApplicationController
  def index
    @lightning_talks = LightningTalk.all
  end
end
