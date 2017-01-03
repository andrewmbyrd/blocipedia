class User < ApplicationRecord
  has_many :wikis
  attr_accessor :standard, :admin, :premium
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save {self.email = email.downcase}
  after_initialize { self.role = :standard }

  enum role: [:standard, :admin, :premium]

end
