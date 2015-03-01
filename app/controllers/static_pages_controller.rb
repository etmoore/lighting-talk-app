class StaticPagesController < ApplicationController
  skip_before_action :ensure_current_user
  def index
    @days = Day.all
    @classes = ["success", "info", "danger", "warning", "active"]
  end
end
