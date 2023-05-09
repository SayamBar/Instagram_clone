class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image, dependent: :destroy
  has_many :likes, as: :likeable

  validates :caption, presence: true
  validates :user_id, presence: true

  after_destroy :log_destroy_action
  after_commit :log_post_saved_to_db, on: :create

  scope :recent, -> { where("updated_at > ?",5.days.ago) }

  def log_destroy_action
    puts "Post destroyed"
  end

  def log_post_saved_to_db
    puts "Post created"
  end
end
