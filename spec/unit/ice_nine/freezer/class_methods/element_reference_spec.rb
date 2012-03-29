# encoding: utf-8

require 'spec_helper'
require 'ice_nine/freezer'
require 'ice_nine/freezer/enumerable'

describe IceNine::Freezer, '.[]' do
  subject { object[mod] }

  let(:object)  { described_class }
  let(:freezer) { object::Object  }

  describe 'when the module matches a descendant' do
    let(:freezer) { Class.new(object) }
    let(:mod)     { Class             }

    before do
      object.const_set(mod.name, freezer)
    end

    after do
      object.send(:remove_const, mod.name)
    end

    it 'returns the freezer' do
      should be(freezer)
    end
  end

  describe 'when the module matches a descendant inside a namespace' do
    let(:namespace) { Class.new(object) }
    let(:freezer)   { Class.new(object) }
    let(:mod)       { Application::User }

    before :all do
      module ::Application
        class User; end
      end
    end

    after :all do
      ::Application.send(:remove_const, :User)
      Object.send(:remove_const, :Application)
    end

    before do
      namespace.const_set(:User, freezer)
      object.const_set(:Application, namespace)
    end

    after do
      namespace.send(:remove_const, :User)
      object.send(:remove_const, :Application)
    end

    it 'returns the freezer' do
      should be(freezer)
    end
  end

  describe 'when the module is a struct' do
    let(:mod)     { Struct.new(:a)           }
    let(:freezer) { IceNine::Freezer::Struct }

    it 'returns the freezer' do
      should be(freezer)
    end
  end

  describe 'when the module does not match a descendant' do
    let(:mod) { Object }

    it 'returns the freezer' do
      should be(freezer)
    end
  end

  describe 'when the module is anonymous' do
    let(:mod) { Class.new }

    it 'returns the freezer' do
      should be(freezer)
    end
  end
end
