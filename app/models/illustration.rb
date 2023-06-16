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

   #検索メソッド、タイトルと内容をあいまい検索する
 def self.illustrations_serach(search)
   Illustration.where(['title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%"])
 end

 def save_illustrations(tags)
   current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
   old_tags = current_tags - tags
   new_tags = tags - current_tags

   # Destroy
   old_tags.each do |old_name|
     self.tags.delete Tag.find_by(tag_name:old_name)
   end

   # Create
   new_tags.each do |new_name|
     illustration_tag = Tag.find_or_create_by(tag_name:new_name)
     self.tags << illustration_tag
   end
 end


end
