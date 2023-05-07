# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :bigint           not null, primary key
#  cat_id     :bigint           not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CatRentalRequest < ApplicationRecord
  validates :cat_id, :start_date, :end_date, :status, presence: true 
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED), message: "not a valid status" }

  belongs_to :cat

  def overlapping_requests(cat_id)
    all_requests_for_cat = CatRentalRequest
      # .select(:start_date, :end_date)
      .where('cat_rental_requests.cat_id = ?', cat_id)
      .pluck(:id, :start_date, :end_date)

    # [[1, jan 1, oct 2], [2, nov 2, dec 1], xxx, xxx]
    interfering_ids = []
    all_requests_for_cat.each do |request|
      if request[1] >= start_date && request[1] <= end_date
        interfering_ids << request[0]
      elsif request[2] >= start_date && request[2] <= end_date
        interfering_ids << request[0]
      elsif start_date >= request[1] && start_date <= request[2]
        interfering_ids << request[0]
      elsif end_date >= request[1] && end_date <= request[2]  
        interfering_ids << request[0]
      end
    end 

    interfering_ids.each do |interfering_id|
      errors.add(:start_date, "interferes with request #{interfering_id}")
    end 


    


  end 

end
