class UsersController < ApplicationController

before_action :load_user, except: [:index, :create, :new]
before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    @users = User.all
    @hashtags = Hashtag.with_questions
  end

  def new
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: 'Пользователь успешно создан и авторизован!'
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Данные обновлены!'
    else
      render 'edit'
    end
  end

  def edit

  end

  def show
    @questions = @user.questions.order(created_at: :desc)
    @new_question = @user.questions.build

    @questions_count = @questions.count
    @answered_questions = @questions.where.not(answer: nil).count
    @unanswered_questions = @questions_count - @answered_questions
  end

  def destroy
    if current_user.present?
      current_user.destroy
      redirect_to users_url, notice: 'User was successfully destroyed.'
    end
  end

  private

  def authorize_user
    reject_user unless @user == current_user
  end

  def load_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username, :avatar_url, :header_color)
  end
end
