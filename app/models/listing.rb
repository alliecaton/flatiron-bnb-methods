class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations

  validates :address, :title, :description, :neighborhood, :listing_type, :price, presence: { message: "can't be blank"}

  after_create :user_status_create
  before_destroy :user_status_destroy

  def user_status_create
    unless self.host.host == true
      self.host.update(host: true)
      self.save
    end
  end 
  
  def user_status_destroy
    if self.host.listings.empty?
      self.host.update(host: false)
      self.save
    end
  end 

  # def user_to_false
  #   if self.host.listings.empty?
  #     self.host.update(host: false)
  #     self.save
  #   end
  # end

  def average_review_rating
    reviews.average(:rating)
  end



end
