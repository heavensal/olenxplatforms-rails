class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to admin_user_path(user), notice: "L'utilisateur a bien été mis à jour"
    else
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      redirect_to admin_users_path, notice: "L'utilisateur a bien été supprimé"
    else
      redirect_to admin_users_path, alert: "Impossible de supprimer l'utilisateur"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end

  def admin_only
    redirect_to root_path, alert: "Vous n'avez pas les droits nécessaires" unless current_user.admin?
  end
end
