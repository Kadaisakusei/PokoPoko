class Tag < ApplicationRecord

  has_many :tagmaps, dependent: :destroy
  has_many :illustrations, through: :tagmaps

end
