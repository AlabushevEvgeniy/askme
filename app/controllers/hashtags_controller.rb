class HashtagsController < ApplicationController

  def show
    @hashtag = Hashtag.find_by!(id: params[:id])
    @questions = @hashtag.questions
  end
end
