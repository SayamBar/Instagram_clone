class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image, dependent: :destroy
  has_many :likes, as: :likeable

  validates :caption, presence: true
  validates :user_id, presence: true

  after_destroy :destroy_all_likes
  after_commit :log_post_saved_to_db, on: :create

  scope :recent, -> { where("updated_at > ?",5.days.ago) }

  around_create :time_create

  # private

  def time_create
    start_time = Time.now
    yield
    end_time = Time.now
    puts "Time taken: #{end_time - start_time} seconds"
  end

  def destroy_all_likes
    likes.destroy_all
  end

  def log_post_saved_to_db
    puts "Post created"
  end
end
