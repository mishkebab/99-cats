# == Schema Information
#
# Table name: cats
#
#  id          :bigint           not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ApplicationRecord
    CAT_COLORS=['black', 'brown', 'white', 'orange', 'gray']

    validates :birth_date, :color, :name, :sex, presence: true
    validates :color, inclusion: { in: CAT_COLORS, message: "not valid color"}
    validates :sex, inclusion: { in: %w(F M), message: "not a valid sex" }
    validate :birth_date_cannot_be_future

    def birth_date_cannot_be_future
        today = Date.today
        if (birth_date <=> today) == 1
            errors.add(:birth_date, "is in the future")
        end 
    end 

    def age
        today = Date.today
        age = ((today - birth_date) / 365).to_i
        age
    end 

    has_many :cat_rental_requests,
    dependent: :destroy
    
end
