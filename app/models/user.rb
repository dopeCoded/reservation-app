class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :reservations

  validates :name, presence: true, on: :create
  validates :password, presence: true, on: :create

  has_many :rooms

  # Add this method
  def update_without_password(params, *options)
    params.delete(:password) if params[:password].blank?
    params.delete(:password_confirmation) if params[:password_confirmation].blank?

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end
