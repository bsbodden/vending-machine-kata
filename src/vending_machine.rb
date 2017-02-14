class VendingMachine
  attr_reader :coins
  attr_reader :coin_return

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

  DISPLAY_MESSAGES = {
    thank_you: 'THANK YOU',
    insert_coin: 'INSERT COIN',
    product_price: "PRICE %s",
    sold_out: 'SOLD OUT'
  }

  def initialize
    initialize_coins
    initialize_coin_return
    initialize_display
    initialize_inventory
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
      initialize_coins

      product
    else
      display_insert_coin if no_coins?
      in_stock?(product) ? display_product_price(product) : display_sold_out

      nil
    end
  end

  def press_return_coins
    @coin_return.concat @coins
    initialize_coins
  end

  def current_amount
    @coins.inject(0) { |total, coin| total + VALID_COINS[coin] }
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

  private

  def initialize_coins
    @coins = []
  end

  def initialize_coin_return
    @coin_return = []
  end

  def initialize_display
    @display = ['INSERT COIN']
  end

  def initialize_inventory
    @inventory = {
      cola: 50,
      chips: 50,
      candy: 100
    }
  end

  def update_display_with_amount
    @display.pop if @display.size > 1
    @display << format_money(current_amount)
  end

  def format_money(cents)
    format("$%.2f", cents / 100.0)
  end

  def valid_coin?(coin)
    VALID_COINS.keys.include? coin
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
    current_amount >= ALLOWED_PRODUCTS[product]
  end

  def display_thank_you
    @display << DISPLAY_MESSAGES[:thank_you]
  end

  def display_insert_coin
    @display << DISPLAY_MESSAGES[:insert_coin]
  end

  def display_product_price(product)
    @display << DISPLAY_MESSAGES[:product_price] % format_money(ALLOWED_PRODUCTS[product])
  end

  def display_sold_out
    @display << DISPLAY_MESSAGES[:sold_out]
  end
end
