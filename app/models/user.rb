class User < ApplicationRecord
  devise :ldap_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tweets, dependent: :destroy
  has_many :connections, foreign_key: 'follower_id', dependent: :destroy
  has_many :inverse_connections, foreign_key: 'followed_id', class_name: 'Connection', dependent: :destroy
  has_many :following, through: :connections, source: :followed
  has_many :followers, through: :inverse_connections, source: :follower
end
