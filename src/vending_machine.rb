class VendingMachine
  attr_reader :coins
  attr_reader :coin_return

  DENOMINATIONS = {
    nickle: 5,
    dime: 10,
    quarter: 25
  }

  PRODUCTS = {
    cola: 100,
    chips: 50,
    candy: 65
  }

  MESSAGES = {
    thank_you: 'THANK YOU',
    insert_coin: 'INSERT COIN',
    product_price: "PRICE %s",
    sold_out: 'SOLD OUT',
    exact_change: 'EXACT CHANGE ONLY'
  }

  def initialize
    initialize_coins
    initialize_coin_return
    initialize_inventory
    initialize_bank
    initialize_display
  end

  def insert(coin)
    if valid_coin?(coin)
      accept_coin(coin)
      update_display_with_amount

      :ok
    else
      reject_coin(coin)

      :rejected
    end
  end

  def press_button(product)
    if enough_money_to_purchase?(product) && in_stock?(product)
      initialize_display
      display_thank_you
      collect_payment_and_make_change(product)

      product
    else
      display_insert_coin if no_coins?
      in_stock?(product) ? display_product_price(product) : display_sold_out

      nil
    end
  end

  def press_return_coins
    move_coins_to_coin_return
    reset_coins
  end

  def current_amount
    value_of_coins(@coins)
  end

  def current_amount_in_coin_return
    value_of_coins(@coin_return)
  end

  def display
    @display.size > 1 ? @display.pop : @display.first
  end

  def inventory(product, level = nil)
    unless level
      @inventory[product]
    else
      @inventory[product] = level
    end
  end

  def in_stock?(product)
    inventory(product) > 0
  end

  def clear_bank
    @bank = []
    initialize_display
  end

  private

  def initialize_coins
    @coins = []
  end

  def reset_coins
    initialize_coins
  end

  def initialize_coin_return
    @coin_return = []
  end

  def initialize_bank
    @bank = Array.new(100, :nickle) +
            Array.new(100, :dime) +
            Array.new(100, :quarter)
  end

  def initialize_display
    @display = []
    exact_change_required? ? display_exact_change : display_insert_coin
  end

  def initialize_inventory
    @inventory = {
      cola: 50,
      chips: 50,
      candy: 100
    }
  end

  def collect_payment_and_make_change(product)
    change_amount = current_amount - product_price(product)
    move_coins_to_bank
    reset_coins
    maybe_make_change(change_amount)
  end

  def update_display_with_amount
    @display.pop if @display.size > 1
    @display << format_money(current_amount)
  end

  def format_money(cents)
    format("$%.2f", cents / 100.0)
  end

  def valid_coin?(coin)
    DENOMINATIONS.keys.include? coin
  end

  def no_coins?
    @coins.empty?
  end

  def accept_coin(coin)
    @coins << coin
  end

  def reject_coin(coin)
    @coin_return << coin
  end

  def enough_money_to_purchase?(product)
    current_amount >= product_price(product)
  end

  def move_coins_to_coin_return
    @coin_return.concat @coins
  end

  def move_coins_to_bank
    @bank.concat @coins
  end

  def display_thank_you
    @display << MESSAGES[:thank_you]
  end

  def display_insert_coin
    @display << MESSAGES[:insert_coin]
  end

  def display_product_price(product)
    @display << MESSAGES[:product_price] % format_money(product_price(product))
  end

  def display_sold_out
    @display << MESSAGES[:sold_out]
  end

  def display_exact_change
    @display << MESSAGES[:exact_change]
  end

  def value_of_coins(coins)
    coins.inject(0) { |total, coin| total + coin_value(coin) }
  end

  def product_price(product)
    PRODUCTS[product]
  end

  def maybe_make_change(amount)
    @coin_return.concat make_change(amount) if amount > 0
  end

  def coin_value(coin)
    DENOMINATIONS[coin]
  end

  def make_change(amount)
    coins = @bank.dup
    coins_value = value_of_coins(coins)

    if amount <= coins_value
      coins = coins.sort_by { |coin| coin_value(coin) }

      collected = []
      collected_value = 0

      while (collected_value < amount) && !coins.empty? do
        coin = coins.pop

        if coin && (collected_value + coin_value(coin) <= amount)
          collected << coin
        end

        collected_value = value_of_coins(collected)
      end

      collected
    end
  end

  # It must be possible to combine deposited coins to total the exact price of
  # an item before the item can be dispensed.
  def exact_change_required?
    value = PRODUCTS.map do |name, value|
      change = make_change(value)
      change.nil? || change.empty?
    end.all?
  end
end
