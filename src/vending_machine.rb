class VendingMachine

  VALID_COINS = [:nickle, :dime, :quarter]

  def insert(coin)
    @coins ||= []

    if VALID_COINS.include? coin
      @coins << :nickle
      :ok
    else
      :rejected
    end
  end
end
