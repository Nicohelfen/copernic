class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :userpermits, dependent: :destroy
  has_many :compagnies, through: :userpermits

  ActiveAdmin.setup do |config|
  # [...]
  config.authentication_method = :authenticate_admin!
  # [...]
  config.current_user_method = :current_user
  # [...]
  config.logout_link_path = :destroy_user_session_path
  # [...]
  config.logout_link_method = :delete
  end


end
