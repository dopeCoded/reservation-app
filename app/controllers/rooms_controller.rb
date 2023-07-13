class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update]

  def index
    @rooms = Room.search(params[:search]).search_by_area(params[:area])
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

  private

  def set_room
    @room = Room.find_by(id: params[:id])
    redirect_to(rooms_path, alert: "Room not found.") unless @room
  end

  def room_params
    params.require(:room).permit(:name, :description, :price, :address, :image)
  end
end
