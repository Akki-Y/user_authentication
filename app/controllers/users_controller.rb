class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.signup_confirmation(@user).deliver_now
      redirect_to user_confirmation_path, notice: "Registration successfull. Please Verify your email "
    else
      render :new
    end
  end

  def verify
    @user = User.find_by(verification_token: params[:token]) # Ensure the token is unique
    if @user 
      @user.update(verified: true, verification_token: nil)
      redirect_to @user, notice: 'Your account has been verified.'
    else
      redirect_to root_path, alert: 'Invalid verification link.'
    end
  end

  def confirmation
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
