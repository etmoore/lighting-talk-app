class WelcomeController < ApplicationController
  skip_before_action :ensure_current_user
  def index
    @days = Day.all
    @upcoming_days = @days.select { |d| Date.today < d.talk_date }
    @previous_days = @days.select { |d| Date.today > d.talk_date }
    @classes = ["success", "info", "danger", "warning", "active"]
  end
end
