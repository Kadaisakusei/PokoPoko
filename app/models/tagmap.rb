class Tagmap < ApplicationRecord
  belongs_to :illustration
  belongs_to :tag
end
