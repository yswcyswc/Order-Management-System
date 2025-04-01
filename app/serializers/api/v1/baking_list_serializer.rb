module Api::V1
  class BakingListSerializer
    include FastJsonapi::ObjectSerializer

    attributes :name, :quantity
  end
end
