class IdeasController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_portfolio, only: [ :index, :show ]

  def index
    params.permit(q: {})

    if @portfolio
      @ideas = @portfolio.ideas
    else
      @q = Idea.ransack(params[:q])
      @ideas = @q.result(distinct: true).with_attached_avatar
    end
  end

  def show
    @idea = @portfolio ? @portfolio.ideas.with_attached_avatar.find(params[:id]) : Idea.with_attached_avatar.find(params[:id])
  end

  private

  def set_portfolio
    @portfolio = Portfolio.find(params[:portfolio_id]) if params[:portfolio_id]
  end
end
