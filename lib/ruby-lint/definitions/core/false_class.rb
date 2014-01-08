# This file was automatically generated, any manual changes will be lost the
# next time this file is generated.
#
# Platform: rbx 2.2.3.n364

RubyLint.registry.register('FalseClass') do |defs|
  defs.define_constant('FalseClass') do |klass|
    klass.inherits(defs.constant_proxy('Object'))
    klass.inherits(defs.constant_proxy('JSON::Ext::Generator::GeneratorMethods::FalseClass'))
    klass.inherits(defs.constant_proxy('ImmediateValue'))

    klass.define_method('yaml_tag_subclasses?')

    klass.define_instance_method('&') do |method|
      method.define_argument('other')
    end

    klass.define_instance_method('^') do |method|
      method.define_argument('other')
    end

    klass.define_instance_method('__marshal__') do |method|
      method.define_argument('ms')
    end

    klass.define_instance_method('inspect')

    klass.define_instance_method('pretty_print') do |method|
      method.define_argument('q')
    end

    klass.define_instance_method('pretty_print_cycle') do |method|
      method.define_argument('q')
    end

    klass.define_instance_method('taguri')

    klass.define_instance_method('taguri=')

    klass.define_instance_method('to_s')

    klass.define_instance_method('to_yaml') do |method|
      method.define_optional_argument('opts')
    end

    klass.define_instance_method('|') do |method|
      method.define_argument('other')
    end
  end
end
