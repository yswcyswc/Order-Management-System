class User < ApplicationRecord
  # get modules to help with some functionality
  include Deletions
  include Activeable::InstanceMethods
  extend Activeable::ClassMethods
  include UserAuthentication

  # Relationships
  has_one :customer
  has_one :employee

  # Scopes
  scope :alphabetical, -> { order(:username) }
  scope :employees,    -> { where.not(role: 'customer') }

  # Validations
  validates :username, presence: true, uniqueness: { case_sensitive: false}
  validates :role, presence: true, inclusion: { in: %w[manager baker shipper customer], message: "is not a recognized role in system" }
  validates_presence_of :password, on: :create 
  validates_presence_of :password_confirmation, on: :create 
  validates_confirmation_of :password, on: :create, message: "does not match"
  validates_length_of :password, minimum: 4, message: "must be at least 4 characters long", allow_blank: true

  # Callbacks
  before_destroy :cannot_destroy_object
  
end