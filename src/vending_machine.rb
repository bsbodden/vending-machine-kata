class VendingMachine
  def insert(coin)
    @coins ||= []

    if coin == :nickle || coin == :dime
      @coins << :nickle
      :ok
    else
      :rejected
    end
  end
end
