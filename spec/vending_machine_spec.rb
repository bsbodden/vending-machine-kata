require 'spec_helper'
require_relative '../src/vending_machine'

describe VendingMachine, '#insert' do
  context 'When inserting a nickle,' do
    it 'is accepted' do
      pending('VendingMachine#insert')
      @vending_machine = VendingMachine.new

      expect(@vending_machine.insert(:nickle)).to be(:ok)
    end
  end
end
