class Order < ApplicationRecord
  # get module to help with some functionality
  require 'base64'
  include Validations
  include Deletions
  include OrderPayment
  include OrderShipping

  # Relationships
  belongs_to :customer
  belongs_to :address
  has_many :order_items
  has_many :items, through: :order_items

  # Scopes
  scope :chronological,  -> { order(date: :desc) }
  scope :paid,           -> { where.not(payment_receipt: nil) }
  scope :for_customer,   ->(customer_id) { where(customer_id: customer_id) }
  scope :for_period,     ->(start_date, end_date) { where('date >= ? and date <= ?', start_date.to_date, end_date.to_date).order(:date) }
  scope :open_orders,    -> { joins(:order_items).where('shipped_on IS NULL').group(:id) }
  scope :shipped_orders, -> { joins(:order_items).where('shipped_on IS NOT NULL').group(:id) }

  # Validations
  # validates_date :date    ## handled now by callback to set date to today
  validates_numericality_of :grand_total, greater_than_or_equal_to: 0, allow_blank: true
  validate -> { is_active_in_system(:customer) }
  validate -> { is_active_in_system(:address) }

  # Other methods
  def is_editable?
    !self.order_items.unshipped.empty?
  end

  def item_count
    self.order_items.inject(0){|sum, oi| sum + oi.quantity}
  end

  # Callbacks
  before_create do
    set_date_to_today
  end

  before_destroy do
    check_if_any_order_items_shipped
    if errors.present?
      @destroyable = false
      throw(:abort)
    end
    remove_order_items
  end

  private
  def set_date_to_today
    self.date = Date.current
  end

  def check_if_any_order_items_shipped
    unless self.order_items.shipped.empty?
      errors.add(:base, "This order has already been partially shipped and therefore cannot be deleted.")
    end
  end

  def remove_order_items
    self.order_items.each{ |oi| oi.destroy }
  end

end
