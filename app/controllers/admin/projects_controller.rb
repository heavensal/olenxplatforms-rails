class Admin::ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to admin_project_path(@project), notice: "Le projet a bien été mis à jour"
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      redirect_to admin_projects_path, notice: "Le projet a bien été supprimé"
    else
      redirect_to admin_projects_path, alert: "Impossible de supprimer le projet"
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :avatar)
  end

  def admin_only
    redirect_to root_path, alert: "Vous n'avez pas les droits nécessaires" unless current_user.admin?
  end
end
