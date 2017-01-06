class Base
  def method_missing(method, *args, &block)
    yield block if block_given?
    super
  rescue NoMethodError, NameError => e
    raise e, e.exception, e.backtrace[1..-1]
  end
end

module BaseModule
  def method_missing(method, *args, &block)
    yield block if block_given?
    super
  rescue NoMethodError, NameError => e
    raise e, e.exception, e.backtrace[1..-1]
  end
end

class UsesBase < Base
  def foo1
    bar
  end

  def foo2
    self.bar
  end
end

class IncludesBaseModule
  def foo1
    bar
  end

  def foo2
    self.bar
  end
end

IncludesBaseModule.class_eval do
  include BaseModule
end

require 'rails'
ActiveRecord::Base.class_eval do
  include HasRegionalAttribute
end
class Tableless
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  def foo
    bar
  end
end

begin
  UsesBase.new.foo1
rescue NameError => e
  puts e.backtrace[0]
end

begin
  UsesBase.new.foo2
rescue NoMethodError => e
  puts e.backtrace[0]
end

begin
  IncludesBaseModule.new.foo1
rescue NameError => e
  puts e.backtrace[0]
end

begin
  IncludesBaseModule.new.foo2
rescue NoMethodError => e
  puts e.backtrace[0]
end
