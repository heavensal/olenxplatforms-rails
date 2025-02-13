class Dashboard::IdeasController < ApplicationController
  before_action :authenticate_user!

  def index
    @portfolio = Portfolio.find(params[:portfolio_id])
    @ideas = @portfolio.ideas.with_attached_avatar.order(updated_at: :desc)
  end

  def show
    @portfolio = Portfolio.find(params[:portfolio_id])
    @idea = @portfolio.ideas.with_attached_avatar.find(params[:id])
  end

  def new
    @portfolio = Portfolio.find(params[:portfolio_id])
    @idea = @portfolio.ideas.new
  end

  def create
    @portfolio = Portfolio.find(params[:portfolio_id])
    @idea = @portfolio.ideas.new(idea_params)
    if @idea.save
      redirect_to dashboard_portfolio_idea_path(@portfolio, @idea), notice: "L'idée a bien été créée"
    else
      render :new
    end
  end

  def edit
    @portfolio = Portfolio.find(params[:portfolio_id])
    @idea = @portfolio.ideas.find(params[:id])
  end

  def update
    @portfolio = Portfolio.find(params[:portfolio_id])
    @idea = @portfolio.ideas.find(params[:id])
    if @idea.update(idea_params)
      redirect_to dashboard_portfolio_idea_path(@portfolio, @idea), notice: "L'idée de projet a bien été mise à jour"
    else
      render :edit
    end
  end

  def destroy
    @idea = Idea.find(params[:id])
    if @idea.destroy
      redirect_to dashboard_portfolio_ideas_path(@idea.portfolio), notice: "L'idée de projet a bien été supprimée"
    else
      redirect_to dashboard_portfolio_ideas_path(@idea.portfolio), alert: "Impossible de supprimer l'idée"
    end
  end

  private

  def idea_params
    params.require(:idea).permit(:name, :description, :avatar)
  end
end
