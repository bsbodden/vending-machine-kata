class VendingMachine
  attr_reader :coins

  VALID_COINS = {
    nickle: 5,
    dime: 10,
    quarter: 25
  }

  def initialize
    @coins ||= []
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
    'INSERT COIN' if @coins.empty?
  end
end
