# encoding: utf-8

require 'spec_helper'
require 'ice_nine/freezer/no_freeze'

describe IceNine::Freezer::NoFreeze, '.deep_freeze' do
   subject { object.deep_freeze(value) }

  let(:object) { described_class }
  let(:value)  { double('value') }

  it 'returns the object' do
    should be(value)
  end

  it 'does not freeze the object' do
    expect { subject }.to_not change(value, :frozen?).from(false)
  end
end
