class StaticPagesController < ApplicationController
  def index
    @days = Day.all
    @classes = ["success", "info", "danger", "warning", "active"]
  end
end
