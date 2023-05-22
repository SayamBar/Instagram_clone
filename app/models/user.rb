class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_one_attached :avatar, dependent: :destroy

  validates :name, presence: true
  validates :bio, length: { maximum: 20 }
  validates :gender, inclusion: ["Male","Female","Others"]
  validates :email, uniqueness: true

  after_initialize do |user|
    puts "You have initialized an object!"
  end
  before_validation :normalize_name, on: :create
  before_create :attach_avatar
  after_commit :send_welcome_mail, on: :create
  # before_destroy :delete_avatar, on: :delete

  def self.authenticate(email, password)
    u = User.find_for_authentication(email: email)
    u&.valid_password?(password) ? u : nil
  end

  private
    def normalize_name
      self.name = name.downcase.titleize
      # debugger
    end

    def attach_avatar
      # debugger
      self.avatar.attach(io: File.open("../Downloads/user.jpg"),filename: 'user.jpg', content_type: 'image/jpg') if !self.avatar.attached?
      # debugger
    end

    def send_welcome_mail
      # debugger
      UserMailer.with(user: self).welcome_email.deliver_later
    end
    # def delete_avatar
    #   self.avatar.purge if self.avatar.attached?
    # end
end
