class Dashboard::ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @portfolio = Portfolio.find(params[:portfolio_id])
    @projects = @portfolio.projects.with_attached_avatar.order(updated_at: :desc)
  end

  def show
    @portfolio = Portfolio.find(params[:portfolio_id])
    @project = @portfolio.projects.with_attached_avatar.find(params[:id])
  end

  def new
    @portfolio = Portfolio.find(params[:portfolio_id])
    @project = @portfolio.projects.new
  end

  def create
    @portfolio = Portfolio.find(params[:portfolio_id])
    @project = @portfolio.projects.new(project_params)
    if @project.save
      redirect_to dashboard_portfolio_project_path(@portfolio, @project), notice: 'L\'idée a bien été créée'
    else
      render :new
    end
  end

  def edit
    @portfolio = Portfolio.find(params[:portfolio_id])
    @project = @portfolio.projects.find(params[:id])
  end

  def update
    @portfolio = Portfolio.find(params[:portfolio_id])
    @project = @portfolio.projects.find(params[:id])
    if @project.update(project_params)
      redirect_to dashboard_portfolio_project_path(@portfolio, @project), notice: 'L\'idée de projet a bien été mise à jour'
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      redirect_to dashboard_portfolio_projects_path(@project.portfolio), notice: 'L\'idée de projet a bien été supprimée'
    else
      redirect_to dashboard_portfolio_projects_path(@project.portfolio), alert: 'Impossible de supprimer l\'idée'
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :avatar)
  end
end
