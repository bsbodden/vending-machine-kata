class VendingMachine
  def insert(coin)
    @coins ||= []

    if coin == :nickle
      @coins << :nickle
      :ok
    end
  end
end
