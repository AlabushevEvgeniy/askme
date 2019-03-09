class UsersController < ApplicationController

before_action :load_user, except: [:index, :create, :new]

  def index
    # Создаём массив из двух болванок пользователей. Вызываем метод # User.new, который создает модель, не записывая её в базу.
    # У каждого юзера мы прописали id, чтобы сымитировать реальную
    # ситуацию – иначе не будет работать хелпер путей
    # @users = [
    #   User.new(
    #     id: 1,
    #     name: 'Vadim',
    #     username: 'installero',
    #     avatar_url: 'https://secure.gravatar.com/avatar/' \
    #       '71269686e0f757ddb4f73614f43ae445?s=100'
    #   ),
    #   User.new(
    #     id: 2, name: 'Misha', username: 'aristofun'
    #     )
    # ]
    @users = User.all
  end

  def new
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new(user_params)

    if @user.save
      redirect_to root_url, notice: 'Пользователь успешно создан!'
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
    # @user = User.new(
    #   name: 'Vadim',
    #   username: 'installero',
    #   avatar_url: 'https://secure.gravatar.com/avatar/' \
    #   '71269686e0f757ddb4f73614f43ae445?s=100'
    # )

    # @questions = [
    #   Question.new(text: 'Как дела?', created_at: Date.parse('03.03.2019')),
    #   Question.new(text: 'В чем смысл жизни?', created_at: Date.parse('03.03.2019'))
    # ]

    # @new_question = Question.new

    @questions = @user.questions.order(created_at: :desc)
    @new_question = @user.questions.build
  end

  private

  def load_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username, :avatar_url)
  end
end
