class VendingMachine
  attr_reader :coins

  VALID_COINS = {
    nickle: 5,
    dime: 10,
    quarter: 25
  }

  ALLOWED_PRODUCTS = {
    cola: 100,
    chips: 50,
    candy: 65
  }

  def initialize
    @coins ||= []
    @display ||= []
    @display << 'INSERT COIN'
  end

  def insert(coin)
    if VALID_COINS.keys.include? coin
      @coins << coin
      :ok
    else
      :rejected
    end
  end

  def current_amount
    @coins.inject(0) { |total, coin| total + VALID_COINS[coin] }
  end

  def display
    @display.size > 1 ? @display.pop : @display.first
  end

  def press_button(product)
    if current_amount >= ALLOWED_PRODUCTS[product]
      @display << 'THANK YOU'
      @coins.clear
      product
    end
  end
end
