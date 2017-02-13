require 'spec_helper'
require_relative '../src/vending_machine'

describe VendingMachine do

  # The vending machine will accept valid coins (nickels, dimes, and quarters)
  # and reject invalid ones (pennies).

  describe '#insert' do
    before(:each) do
      @vending_machine = VendingMachine.new
    end

    context 'When inserting a nickle,' do
      it 'is accepted' do
        expect(@vending_machine.insert(:nickle)).to be(:ok)
      end

      it 'is added to the coins in the current transaction' do
        @vending_machine.insert(:nickle)
        expect(@vending_machine.coins).to contain_exactly(:nickle)
      end
    end

    context 'When inserting a dime,' do
      it 'is accepted' do
        expect(@vending_machine.insert(:dime)).to be(:ok)
      end

      it 'is added to the coins in the current transaction' do
        @vending_machine.insert(:dime)
        expect(@vending_machine.coins).to contain_exactly(:dime)
      end
    end

    context 'When inserting a quarter,' do
      it 'is accepted' do
        expect(@vending_machine.insert(:quarter)).to be(:ok)
      end

      it 'is added to the coins in the current transaction' do
        @vending_machine.insert(:quarter)
        expect(@vending_machine.coins).to contain_exactly(:quarter)
      end
    end

    context 'When inserting a penny,' do
      it 'is rejected' do
        expect(@vending_machine.insert(:penny)).to be(:rejected)
      end

      it 'is NOT added to the coins in the current transaction' do
        @vending_machine.insert(:penny)
        expect(@vending_machine.coins).to be_empty
      end
    end
  end

  # When a valid coin is inserted the amount of the coin will be added to the
  # current amount

  describe '#current_amount' do
    before(:each) do
      @vending_machine = VendingMachine.new
    end

    context 'When inserting a nickle,' do
      it 'increases the current amount the cents value of a nickle' do
        @vending_machine.insert(:nickle)
        expect(@vending_machine.current_amount).to eq(5)
      end
    end

    context 'When inserting a dime,' do
      it 'increases the current amount the cents value of a dime' do
        @vending_machine.insert(:dime)
        expect(@vending_machine.current_amount).to eq(10)
      end
    end

    context 'When inserting a quarter,' do
      it 'increases the current amount the cents value of a quarter' do
        @vending_machine.insert(:quarter)
        expect(@vending_machine.current_amount).to eq(25)
      end
    end

    context 'When inserting a penny,' do
      it 'does not change the current amount' do
        @vending_machine.insert(:penny)
        expect(@vending_machine.current_amount).to eq(0)
      end
    end
  end

  # - When there are no coins inserted, the machine displays INSERT COIN
  describe '#display' do
    before(:each) do
      @vending_machine = VendingMachine.new
    end

    context 'When there are no coins inserted,' do
      it 'displays INSERT COIN' do
        expect(@vending_machine.display).to eq('INSERT COIN')
      end
    end

  end

  # There are three products: cola for $1.00, chips for $0.50, and candy for $0.65.
  describe 'ALLOWED_PRODUCTS' do
    it 'returns three (3) products' do
      expect(VendingMachine::ALLOWED_PRODUCTS.keys).to contain_exactly(:cola, :chips, :candy)
    end

    it 'returns the value of :cola as $1.00 (in cents)' do
      expect(VendingMachine::ALLOWED_PRODUCTS[:cola]).to eq(100)
    end

    it 'returns the value of :chips as $0.50 (in cents)' do
      expect(VendingMachine::ALLOWED_PRODUCTS[:chips]).to eq(50)
    end

    it 'returns the value of :candy as $0.65 (in cents)' do
      expect(VendingMachine::ALLOWED_PRODUCTS[:candy]).to eq(65)
    end
  end

  # When the respective button is pressed and enough money has been inserted,
  # - the product is dispensed
  # - and the machine displays THANK YOU.
  describe '#press_button' do
    before(:each) do
      @vending_machine = VendingMachine.new
    end

    context 'When the :cola button is pressed' do
      context ' and enough money has been inserted,' do
        before (:each) do
          4.times { @vending_machine.insert(:quarter) }
        end

        it 'dispenses cola' do
          expect(@vending_machine.press_button(:cola)).to eq(:cola)
        end

        it 'displays THANK YOU' do
          @vending_machine.press_button(:cola)
          expect(@vending_machine.display).to eq('THANK YOU')
        end
      end

      context ' and NOT enough money has been inserted,' do
        it 'does not dispense cola' do
          expect(@vending_machine.press_button(:cola)).to be_nil
        end

        it 'displays INSERT COIN' do
          expect(@vending_machine.display).to eq('INSERT COIN')
        end
      end
    end

    context 'When the :chips button is pressed' do
      context ' and enough money has been inserted,' do
        it 'dispenses chips' do
          2.times { @vending_machine.insert(:quarter) }
          expect(@vending_machine.press_button(:chips)).to eq(:chips)
        end
      end

      context ' and NOT enough money has been inserted,' do
        it 'does not dispense chips' do
          expect(@vending_machine.press_button(:chips)).to be_nil
        end

        it 'displays INSERT COIN' do
          expect(@vending_machine.display).to eq('INSERT COIN')
        end
      end
    end

    context 'When the :candy button is pressed' do
      context ' and enough money has been inserted,' do
        it 'dispenses candy' do
          2.times { @vending_machine.insert(:quarter) }
          @vending_machine.insert(:dime)
          @vending_machine.insert(:nickle)
          expect(@vending_machine.press_button(:candy)).to eq(:candy)
        end
      end

      context ' and NOT enough money has been inserted,' do
        it 'does not dispense candy' do
          expect(@vending_machine.press_button(:candy)).to be_nil
        end

        it 'displays INSERT COIN' do
          expect(@vending_machine.display).to eq('INSERT COIN')
        end
      end
    end
  end
end
