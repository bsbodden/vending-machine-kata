require 'spec_helper'
require_relative '../src/vending_machine'

describe VendingMachine, '#insert' do
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
