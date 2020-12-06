class UsersController < ApplicationController
  before_action :authenticate_user,{only: [:index,:show,:edit,:logout]}
  before_action :un_authenticate_user,{only: [:login_form,:login,:signup,:create]}

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def signup
    @user = User.new
  end

  def create
    if @user = User.create(user_params)
      flash[:notice] = "ユーザー登録が完了しました"
      session[:id] = @user.id
      redirect_to("/users/index")
    else
      flash.now[:notice] = "ユーザー登録できませんでした"
      render("users/signup")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.nickname = params[:user][:nickname]
    @user.email = params[:user][:email]
    @user.pw = params[:user][:pw]
    @user.image = params[:user][:image]
    if @user.save
      flash[:notice] = "ユーザ情報を更新しました"
      redirect_to("/users/index")
    else
      flash[:notice] = "ユーザ情報が更新できません"
      redirect_to("/users/#{params[:id]}/edit")
    end
  end

  def login_form
    @user = User.new
    @email = ""
    @pw = ""
  end

  def login
    @user = User.find_by(email: params[:user][:email],pw: params[:user][:pw])
    if @user
      flash[:notice] = "ログインしました"
      redirect_to("/")
      session[:id] = @user.id
      @current_user = @user
    else
      flash.now[:notice] = "メールアドレスかパスワードが誤っています"
      @email = params[:user][:email]
      @pw = params[:user][:pw]
      @user = User.new
      render("users/login_form")
    end
  end

  def logout
      session[:id] = nil
      flash[:notice] = "ログアウトしました"
      redirect_to("/")
  end

  def user_params
    params.require(:user).permit(:user_id,:nickname,:email,:pw,:image)
  end

  def delete
    @user = User.find_by(id: params[:id])
    if @current_user.id == @user.id
      @user.destroy
      session[:id] = nil
      flash[:notice] = "退会しました"
      redirect_to("/")
    else
      flash[:notice] = "#{@user.nickname}さんを退会させました"
      @user.destroy
      redirect_to("/users/index")
    end
  end

end
