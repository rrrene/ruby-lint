require 'spec_helper'

describe RubyLint::VirtualMachine do
  example 'associate AST nodes and their definitions' do
    tokens = parse('def foobar; end', false)
    vm     = RubyLint::VirtualMachine.new

    vm.iterate(tokens)

    defs   = vm.definitions
    assoc  = vm.associations
    method = tokens.children[0]

    assoc.key?(method).should == true
    assoc[method].should      == defs.lookup(:instance_method, 'foobar')
  end

  context 'method calls' do
    example 'should not add associations' do
      associations = build_associations('foo')
      nodes        = associations.keys

      nodes.length.should  == 1
      nodes[0].type.should == :root
    end

    example 'should not add associations for methods with arguments' do
      associations = build_associations('foo(:bar)')
      nodes        = associations.keys

      nodes.length.should  == 2
      nodes[0].type.should == :root
    end

    example 'should not add associations for methods called on methods' do
      associations = build_associations('foo.bar')
      nodes        = associations.keys
      values       = associations.values

      nodes.length.should  == 2
      nodes[0].type.should == :root
      nodes[1].type.should == :send

      values[1].type.should == :unknown
    end

    example 'should not add associations for stacked methods with arguments' do
      associations = build_associations('foo.bar(:baz)')
      nodes        = associations.keys
      values       = associations.values

      nodes.length.should  == 3
      nodes[0].type.should == :root
      nodes[1].type.should == :sym
      nodes[2].type.should == :send

      values[1].type.should == :sym
      values[2].type.should == :unknown
    end
  end

  context 'calling methods on blocks' do
    before :all do
      @assocs = build_associations('foo { }.bar').values
    end

    example 'create an association for the (block) node' do
      @assocs[1].type.should == :block
    end

    example 'create an association for the (send) node' do
      @assocs[2].type.should == :unknown
    end
  end

  context 'calling nested methods with blocks' do
    before :all do
      @assocs = build_associations('Hash[NUMBERS.map { }]').keys
    end

    example 'associate the return value of NUMBERS.map with the (send) node' do
      @assocs[3].type.should == :send
    end
  end
end
