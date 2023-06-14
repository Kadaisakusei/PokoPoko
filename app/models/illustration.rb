class Illustration < ApplicationRecord

  belongs_to :customer
  #validates :title,presence:true
  #validates :body,presence:true,length:{maximum:200}

  has_many :favorites, dependent: :destroy
   def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
   end

  has_many :post_comments, dependent: :destroy

  has_one_attached :illustration_image
    def get_illustration(width, height)
      unless illustration.attached?
        file_path = Rails.root.join('app/assets/images/no_image.jpg')
        illustration.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
      illustration.variant(resize_to_limit: [width, height]).processed
    end


# 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @illustration = Illustration.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @illustration = Illustration.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @illustration = Illustration.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @illustration = Illustration.where("title LIKE?","%#{word}%")
    else
      @illustration = Illustration.all
    end
  end


end
