module OrderPayment
  extend ActiveSupport::Concern

  included do
    # Virtual attributes related to payment (non-saved)
    attr_accessor :credit_card_number
    attr_accessor :expiration_year
    attr_accessor :expiration_month

    # Validations
    validate :credit_card_number_is_valid
    validate :expiration_date_is_valid

    # Public methods
    def pay
      return false unless self.payment_receipt.nil?
      generate_payment_receipt
      self.save!
      self.payment_receipt
    end
  
    def credit_card_type
      credit_card.type.nil? ? "N/A" : credit_card.type.name
    end

    # Private methods
    private
    def generate_payment_receipt
      self.payment_receipt = Base64.encode64("order: #{self.id}; amount_paid: #{self.grand_total}; received: #{self.date}; card: #{self.credit_card_type} ****#{self.credit_card_number[-4..-1]}; billing zip: #{self.customer.billing_address.zip}")
    end
  
    def credit_card
      CreditCard.new(self.credit_card_number, self.expiration_year, self.expiration_month)
    end
  
    def credit_card_number_is_valid
      return false if self.expiration_year.nil? || self.expiration_month.nil?
      if self.credit_card_number.nil? || credit_card.type.nil?
        errors.add(:credit_card_number, "is not valid")
        return false
      end
      true
    end
  
    def expiration_date_is_valid
      return false if self.credit_card_number.nil? 
      if self.expiration_year.nil? || self.expiration_month.nil? || credit_card.expired?
        errors.add(:expiration_year, "is expired")
        return false
      end
      true
    end
  end
end