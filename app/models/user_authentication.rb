module UserAuthentication 
  extend ActiveSupport::Concern

  included do
    # Use built-in rails support for password protection
    has_secure_password

    # Enum for roles
    enum :role, { customer: 1, baker: 2, shipper: 3, manager: 4 }, scopes: true, default: :customer, suffix: true

    # For role dropdown
    ROLES = [['Customer', 'customer'],['Manager', 'manager'],['Baker', 'baker'],['Shipper', 'shipper']].freeze
  end

  class_methods do
    # login by username
    def authenticate(username, password)
      find_by_username(username).try(:authenticate, password)
    end
  end

end