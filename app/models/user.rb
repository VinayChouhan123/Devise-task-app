class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable,
         authentication_keys: [:login]

  validates :username, presence: true, uniqueness: true
  validates :mobile, presence: true, uniqueness: true

  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy

  has_many :followers, foreign_key: "followed_id", class_name: "Relationship"
  has_many :following, foreign_key: "follower_id", class_name: "Relationship"

  #assign default role
  after_create :assign_default_role


  def assign_default_role
    self.add_role(:newuser) if self.roles.blank?
  end

  #login with email or mobile field
  attr_accessor :login

  def login
    @login || self.mobile || self.email
  end

  private

  def self.find_for_database_authentication(warden_condition)
    conditions = warden_condition.dup
    if(login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(email) = :value",
      { value: login.downcase }]).first
    elsif conditions.has_key?(:email) || conditions.has_key?(:mobile)
      where(conditions.to_h).first
    end
  end

end
