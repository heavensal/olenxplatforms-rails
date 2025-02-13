class PortfoliosController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    params.permit(q: {})
    @q = Portfolio.ransack(params[:q])
    @portfolios = @q.result(distinct: true).with_attached_avatar
  end

  def show
    @portfolio = Portfolio.includes(:ideas, :projects).with_attached_avatar.with_attached_qr_code.find(params[:id])
  end
end
