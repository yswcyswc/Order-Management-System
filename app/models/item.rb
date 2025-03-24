class Item < ApplicationRecord
  # get modules to help with some functionality
  include Validations
  include Deletions
  include Activeable::InstanceMethods
  extend Activeable::ClassMethods
  
  # Relationships
  has_many :order_items
  has_many :item_prices
  has_many :orders, through: :order_items

  # Enums
  enum :category, { breads: 1, muffins: 2, pastries: 3 }, scopes: true, default: :breads, suffix: false

  # Scopes
  scope :alphabetical, -> { order(:name) }
  
  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates_presence_of :category, :units_per_item, :weight
  validates_numericality_of :units_per_item, only_integer: true, greater_than: 0
  validates_numericality_of :weight, greater_than: 0
  validates :category, inclusion: { in: %w[breads muffins pastries], message: "is not a recognized category in system" }

  # Other methods
  def current_price
    curr = self.item_prices.current.first
    if curr.nil?
      return nil
    else
      return curr.price
    end
  end

  def price_on_date(date)
    data = self.item_prices.for_date(date).first
    if data.nil?
      return nil
    else
      return data.price
    end
  end

  def self.popular_items_on(date)
    items_today = Order.where(date: date).map{|o| o.order_items.map{|oi| {oi.item => oi.quantity}}}.flatten
    popular = {}
    items_today.each do |item|
      item.each do |item_type, quantity|
        if popular.has_key?(item_type)
          popular[item_type] += quantity
        else
          popular[item_type] = quantity
        end
      end
    end
    popular.sort_by{|k,v| v}.reverse.to_h
  end

  # Callbacks
  before_destroy do 
    check_if_ever_associated_with_a_shipped_order
    if errors.present?
      @destroyable = false
      throw(:abort)
    else
      remove_unshipped_and_unpaid_order_items
    end
  end

  after_destroy :remove_unshipped_and_unpaid_order_items


  private
  def check_if_ever_associated_with_a_shipped_order
    unless self.order_items.shipped.empty?
      errors.add(:base, "This item cannot be deleted because it has been part of a shipped order.")
    end
  end

  def remove_unshipped_and_unpaid_order_items
    self.order_items.unshipped.each{|oi| oi.destroy if oi.order.payment_receipt.nil?}
  end
end
