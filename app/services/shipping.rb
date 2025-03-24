class Shipping
  def self.calculate_shipping_costs(weight, allowed=5, base_rate=2.00, increment_rate=0.25)
    # for phase 3, only check if weight is nil...
    return nil if weight.nil? #|| (weight.is_a?(Numeric) == false) || (allowed.is_a?(Numeric) == false) || (base_rate.is_a?(Numeric) == false) || (increment_rate.is_a?(Numeric) == false)
    increment = self.calculate_shipping_increase(weight, allowed, increment_rate)
    cost = base_rate + increment
  end

  private
  def self.calculate_shipping_increase(total_weight, allowed, charge)
    return 0 if total_weight <= allowed
    extra = (total_weight - allowed).to_i
    increment = extra * charge
  end  

end