class Room < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :address, presence: true
  validates :area, presence: true, inclusion: { in: ["Tokyo", "Osaka", "Kyoto", "Sapporo"] }
  validates :price, numericality: { greater_than_or_equal_to: 1 , message: "At least 1 yen" }
  scope :search, -> (search_term) { where('name LIKE ? OR description LIKE ?', "%#{search_term}%", "%#{search_term}%") if search_term.present? }
  scope :in_area, -> (area) { where('address LIKE ?', "%#{area}%") if area.present? }

  def index
    @rooms = Room.search(params[:query]).in_area(params[:area])
  end  
end
