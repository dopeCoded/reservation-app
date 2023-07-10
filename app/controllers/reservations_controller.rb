class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:create]

  def index
    @reservations = current_user.reservations
  end  
      
  def show
  end

  def new
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new
  end

  def create
    puts "Current user: #{current_user.inspect}"
    @room = Room.find_by(id: params[:reservation][:room_id])
    if @room.nil?
      # Handle the case where the room doesn't exist
      redirect_to root_path, alert: 'Room not found.'
    else
      @reservation = Reservation.new(reservation_params)
      @reservation.user_id = current_user.id
      @reservation.room = @room
      if @reservation.save
        redirect_to @reservation, notice: 'Reservation was successfully created.'
      else
        puts @reservation.errors.full_messages
        render :new
      end
    end
  end

  def edit
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to @reservation, notice: 'Reservation was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:room_id, :check_in, :check_out, :guests)
  end
end