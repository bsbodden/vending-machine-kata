class VendingMachine
  attr_reader :coins

  VALID_COINS = {
    nickle: 5,
    dime: 10,
    quarter: 25
  }

  def insert(coin)
    @coins ||= []

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
end
