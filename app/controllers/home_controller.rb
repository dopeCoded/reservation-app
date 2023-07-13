class HomeController < ApplicationController
  def index
    if params[:area]
      @rooms = Room.where("area LIKE ?", "%#{params[:area]}%")
    else
      @rooms = Room.all
    end
  end  
end