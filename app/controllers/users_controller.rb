class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :student_profile, :instructor_profile]

  def index
    @users = User.all
  end

  def students_show
  end

  def instructors_show
  end

  def student_profile
  end

  def instructor_profile
  end

  def show
  end

  def new
    @user = User.new
  end

  def add
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        p "This is the  referer #{request.referer}"
        #if the session id is not set then set it when you creature a user (ie login)
        if session[:user_id].nil?
          session[:user_id] = @user.id
        end
        format.html {redirect_to @user, notice: 'User was successfully created.' }
        format.json {render :show, status: :created, location: @user}
      else
        format.html {render :new}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html {redirect_to @user, notice:"User was successfully updated."}
        format.json {render :show, status: :ok, location: @user}
      else
        format.html {render :edit}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    respond_to do |format|
      format.js
      #format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      #format.json { head :no_content }
    end
    @user.destroy
    id = @user.id
    if id == session[:user_id]
      redirect_to logout_url
    end

  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :age, :education_id, :permission_id, :propic, :salary)
    end
end
