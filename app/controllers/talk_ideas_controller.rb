class TalkIdeasController < ApplicationController
  def create
    @talk_idea = TalkIdea.new(params.require(:talk_idea).permit(:name).merge(user_id: current_user.id))
    if @talk_idea.save
      redirect_to root_path, notice: "Thanks for submitting a Talk Idea"
    else
      flash[:notice] = "Something went wrong!"
      render_template "welcome/index"
    end
  end
end
