class QuestionsController < ApplicationController
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, except: [:create]
  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  def create
    @question = Question.new(question_params)
    @question.author = current_user

    if check_captcha(@question) && @question.save
      redirect_to user_path(@question.user), notice: 'Вопрос задан!'
    else
      render :edit
    end
  end

  # PATCH/PUT /questions/1
  def update
    @question.hashtags.destroy_all if @question.present?
    if @question.update!(question_params)
      redirect_to user_path(@question.user), notice: 'Воспрос изменен и сохранен.'
    else
      render :edit
    end
  end

  # DELETE /questions/1
  def destroy
    user = @question.user
    # hashtag = @question.hashtags
    @question.destroy
    # hashtag.destroy if hashtag = nil
    redirect_to user_path(user), notice: 'Вопрос удален.'
  end

  private

    def check_captcha(model)
      current_user.present? || verify_recaptcha(model: model)
    end

    def load_question
      @question = Question.find(params[:id])
    end

    def authorize_user
    reject_user unless @question.user == current_user
  end

  # Only allow a trusted parameter "white list" through.
  def question_params
    # Защита от уязвимости: если текущий пользователь — адресат вопроса,
    # он может менять ответы на вопрос, ему доступно и поле :answer.
    if current_user.present? &&
      params[:question][:user_id].to_i == current_user.id
      params.require(:question).permit(:user_id, :text, :answer, :hashtag_id)
    else
      params.require(:question).permit(:user_id, :text)
    end
  end
end
