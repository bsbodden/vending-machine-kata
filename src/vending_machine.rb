class VendingMachine
  def insert(coin)
    @coins ||= []

    if coin == :nickle
      @coins << :nickle
      :ok
    else
      :rejected
    end
  end
end
