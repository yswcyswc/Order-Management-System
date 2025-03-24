class Employee < ApplicationRecord
  # get modules to help with some functionality
  include Validations
  include Deletions
  include Activeable::InstanceMethods
  extend Activeable::ClassMethods
  
  # Relationships
  belongs_to :user

  # Allow user to be nested within employee
  accepts_nested_attributes_for :user, reject_if: ->(user) { user[:username].blank? }, allow_destroy: true

  # Scopes
  scope :alphabetical,  -> { order(:last_name).order(:first_name) }

  # Validations
  validates_presence_of :last_name, :first_name, :ssn, :date_hired
  validates_format_of :ssn, with: /\A\d{3}[- ]?\d{2}[- ]?\d{4}\z/, message: "should be 9 digits and delimited with dashes only"
  validates_uniqueness_of :ssn
  validates_date :date_hired, on_or_before: ->{ Date.current }
  validates_date :date_terminated, after: :date_hired, on_or_before: ->{ Date.current }, allow_blank: true

  # Callbacks
  before_save -> { strip_nondigits_from(:ssn) }
  before_update :deactive_user_if_employee_inactive
  before_destroy :cannot_destroy_object

  # Other methods
  def name
    "#{last_name}, #{first_name}"
  end

  def proper_name
    "#{first_name} #{last_name}"
  end

  # Private methods
  private
  def deactive_user_if_employee_inactive
    if !self.active && !self.user.nil?
      self.user.active = false
      self.user.save
    end
  end

end
