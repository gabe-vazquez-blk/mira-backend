class UserStocksController < ApplicationController

  def index
   user_stocks = UserStock.all 
    render json: user_stocks
  end 

  def create
    user_stock = UserStock.create({
      user_id: session_user.id,
      stock_id: params[:stock_id]
    })

    render json: user_stock.stock
  end

  def delete
    user_stock = UserStock.find_by({user_id: session_user.id , stock_id:params[:stock_id]})
    user_stock.destroy
  end

end
