require File.expand_path('../../../helper', __FILE__)

describe RubyLint::Analyze::UnusedVariables do
  describe 'global scope' do
    should 'error for unused local variables' do
      report = build_report('number = 1', RubyLint::Analyze::UnusedVariables)
      entry  = report.entries[0]

      entry.is_a?(RubyLint::Report::Entry).should == true

      entry.line.should    == 1
      entry.column.should  == 0
      entry.message.should == 'unused local variable number'
    end

    should 'error for unused global variables' do
      report = build_report('$number = 1', RubyLint::Analyze::UnusedVariables)
      entry  = report.entries[0]

      entry.is_a?(RubyLint::Report::Entry).should == true

      entry.line.should    == 1
      entry.column.should  == 0
      entry.message.should == 'unused global variable $number'
    end

    should 'error for unused constants' do
      report = build_report('NUMBER = 10', RubyLint::Analyze::UnusedVariables)
      entry  = report.entries[0]

      entry.is_a?(RubyLint::Report::Entry).should == true

      entry.line.should    == 1
      entry.column.should  == 0
      entry.message.should == 'unused constant NUMBER'
    end

    should 'error for unused constant paths' do
      code = <<-CODE
module A
end

A::B = 10
      CODE

      report = build_report(code, RubyLint::Analyze::UnusedVariables)

      report.entries.length.should == 1

      entry = report.entries[0]

      entry.is_a?(RubyLint::Report::Entry).should == true

      entry.line.should    == 4
      entry.column.should  == 3
      entry.message.should == 'unused constant B'
    end
  end

  describe 'method scopes' do
    should 'error for unused local variables' do
      code = <<-CODE
def some_method
  number = 10
end
      CODE

      report = build_report(code, RubyLint::Analyze::UnusedVariables)
      entry  = report.entries[0]

      entry.is_a?(RubyLint::Report::Entry).should == true

      entry.line.should    == 2
      entry.column.should  == 2
      entry.message.should == 'unused local variable number'
    end
  end
end
