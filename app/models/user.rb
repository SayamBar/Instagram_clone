class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_one_attached :avatar

  validates :name, presence: true
  validates :bio, length: { maximum: 20 }
  validates :gender, inclusion: ["male","female","others"]
  validates :email, uniqueness: true

  def self.authenticate(email, password)
    u = User.find_for_authentication(email: email)
    u&.valid_password?(password) ? true : false
  end
end
