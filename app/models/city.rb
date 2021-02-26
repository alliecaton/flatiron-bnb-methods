class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods
  has_many :reservations, :through => :listings

  ## 2014-05-01 
  # def city_openings(start, end)
  #   self.listings.map do |listing|
  #     where 
  # end

  def self.highest_ratio_res_to_listings
    array = []
    self.all.each do |city|
      city.listings.map do |listing|
        array << city.listings.count - listing.reservations.count
        array << listing.neighborhood.city.name
      end 
    end
    self.find_by(name: array[1])
  end

    # self.all.listings.map do |listing|
      #   if listing.neighborhood.city == self 
      #     listing.reservations
      #   end 
      # end.sort.first

  def self.most_res
    sorted = self.all.sort_by do |n|
      n.reservations.count
    end
    sorted.last
  end 


end

