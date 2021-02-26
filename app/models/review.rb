class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"

  validates :description, :rating, presence: true
  # validates_associated :reservation, presence: true
  validates_associated :guest, presence: true

  validate :check_reservation

  def check_reservation
    unless self.reservation && self.reservation.checkout && self.reservation.status == "accepted"
      errors.add(:reservation, "Reservation is invalid")
    end
  end

  # def validate_existence
  #   unless (self.reservation.status == "accepted") && (Time.now > self.reservation.checkout)
  #     self.errors.add("Invalid")
  #   end
  # end

end
