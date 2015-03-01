class WelcomeController < ApplicationController
  skip_before_action :ensure_current_user
  def index
    @days = Day.all.sort_by { |d| d.talk_date}
    @upcoming_days = @days.select { |d| Date.today < d.talk_date }
    @previous_days = @days.select { |d| Date.today > d.talk_date }
    @classes = ["success", "info", "danger", "warning", "active"]
    @talk_ideas = TalkIdea.all
    @talk_idea = TalkIdea.new
  end
end
