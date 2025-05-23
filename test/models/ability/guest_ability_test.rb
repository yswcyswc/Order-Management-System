require 'test_helper'

class GuestAbilityTest < ActiveSupport::TestCase
  context "Within context" do
    should "verify the abilities of guest users to read items, become customers" do
      create_guest_abilities
      deny @guest_ability.can? :manage, :all
      assert @guest_ability.can? :show, Item
      assert @guest_ability.can? :index, Item
      assert @guest_ability.can? :create, Customer
    end
  end
end