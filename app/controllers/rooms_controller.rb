class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update]

  def index
    @rooms = Room.all
  end

  def show
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.user = current_user
    if @room.save
      redirect_to @room, notice: 'Room was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: 'Room was successfully updated.'
    else
      render :edit
    end
  end

  def search
    if params[:search].blank? && params[:area].blank?
      @rooms = Room.all
    else
      @rooms = Room.all
      @rooms = @rooms.where('name LIKE ? OR description LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
      @rooms = @rooms.where('address LIKE ?', "%#{params[:area]}%") if params[:area].present?
    end
  end
  

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :description, :price, :address, :image, :area)
  end
end
