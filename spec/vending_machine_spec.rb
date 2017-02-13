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
end
