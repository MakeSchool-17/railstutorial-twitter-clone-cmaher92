require "test/unit"

class Pizza
  # accessor is reader and writer
  attr_accessor :slices

  def initialize(slices)
    @slices = slices
    @toppings = []
  end

  def add_topping(topping)
    @toppings << topping
  end

  def toppings
    # shallow copy
    @toppings.dup
  end
end


class TestSimpleNumber < Test::Unit::TestCase

  def setup
    # similar to __init__ in python
    @pizza = Pizza.new(2)
  end

  def test_init
    assert_equal(2, @pizza.slices)
    assert_equal()
  end

  def test_has_toppings
    @pizza.add_topping("mushrooms")
    assert_equal(1, @pizza.toppings.size)
end
