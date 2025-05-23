FactoryBot.define do
  factory :item do
    name { "Honey Wheat Bread" }
    description { "A most tasty treat from the bakers at Bread Express. Your family will love it!" }
    category { 1 }
    units_per_item { 1 }
    weight { 1.0 }
    active { true }
  end
end
