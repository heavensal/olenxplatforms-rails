class Dashboard::ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portfolio, only: %i[index show new create edit update]

  def index
    @projects = @portfolio.projects.with_attached_avatar.order(updated_at: :desc)
  end

  def show
    @project = @portfolio.projects.with_attached_avatar.find(params[:id])
  end

  def new
    @project = @portfolio.projects.new
  end

  def create
    @project = @portfolio.projects.new(project_params)
    if @project.save
      redirect_to dashboard_portfolio_project_path(@project), notice: "L'idée a bien été créée"
    else
      render :new
    end
  end

  def edit
    @project = @portfolio.projects.find(params[:id])
  end

  def update
    @project = @portfolio.projects.find(params[:id])
    if @project.update(project_params)
      redirect_to dashboard_portfolio_project_path(@project), notice: "L'idée de projet a bien été mise à jour"
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      redirect_to dashboard_portfolio_path, notice: "L'idée de projet a bien été supprimée"
    else
      redirect_to dashboard_portfolio_project_path(@project), alert: "Impossible de supprimer l'idée"
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :avatar)
  end

  def set_portfolio
    @portfolio = current_user.portfolio
  end
end
