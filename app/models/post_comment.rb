class PostComment < ApplicationRecord

  belongs_to :customer
  belongs_to :illustration

end
