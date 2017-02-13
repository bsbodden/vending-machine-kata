require 'spec_helper'
require_relative '../src/vending_machine'

describe VendingMachine, '#insert' do
  context 'When inserting a nickle,' do
    it 'is accepted' do
      @vending_machine = VendingMachine.new

      expect(@vending_machine.insert(:nickle)).to be(:ok)
    end
  end

  context 'When inserting a dime,' do
    it 'is accepted' do
      @vending_machine = VendingMachine.new

      expect(@vending_machine.insert(:dime)).to be(:ok)
    end
  end

  context 'When inserting a penny,' do
    it 'is rejected' do
      @vending_machine = VendingMachine.new

      expect(@vending_machine.insert(:penny)).to be(:rejected)
    end
  end
end
