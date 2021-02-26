class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  validates :checkin, :checkout, presence: true
  # validate :available_res
  validate :res_owner
  validate :invalid_checkin_checkout

  
  def duration 
    self.checkout - self.checkin
  end 

  def total_price
    self.listing.price * duration 
  end

  def res_owner
    unless self.guest != self.listing.host
      self.errors[:guest] << "Invalid Guest"
    end
  end

  def invalid_checkin_checkout
    unless self.checkin && self.checkout && self.checkin <= self.checkout 
      self.errors[:guest_id] << "This date is invalid"
    end
  end

  def available_res
    Reservation.all.each do |r|
      booked = r.checkin..r.checkout
      byebug
      if booked.include?(self.checkin) || booked.include?(self.checkout)
        errors.add[:guest_id] << "This reservation is not available"
      end 
    end
  end

end
