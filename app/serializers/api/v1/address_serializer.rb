module Api::V1
  class AddressSerializer
    include FastJsonapi::ObjectSerializer
    set_type :address
    attributes :recipient, :street_1, :street_2, :city, :state, :zip
  end
end
