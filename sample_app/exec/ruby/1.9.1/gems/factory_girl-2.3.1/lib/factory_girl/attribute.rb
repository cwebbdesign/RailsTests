require "factory_girl/attribute/static"
require "factory_girl/attribute/dynamic"
require "factory_girl/attribute/association"
require "factory_girl/attribute/sequence"

module FactoryGirl

  class Attribute #:nodoc:
    include Comparable

    attr_reader :name, :ignored

    def initialize(name, ignored)
      @name = name.to_sym
      @ignored = ignored
      ensure_non_attribute_writer!
    end

    def add_to(proxy)
    end

    def association?
      false
    end

    def priority
      1
    end

    def aliases_for?(attr)
      FactoryGirl.aliases_for(attr).include?(name)
    end

    def <=>(another)
      return nil unless another.is_a? Attribute
      self.priority <=> another.priority
    end

    def ==(another)
      self.object_id == another.object_id
    end

    private

    def ensure_non_attribute_writer!
      if @name.to_s =~ /=$/
        attribute_name = $`
        raise AttributeDefinitionError,
          "factory_girl uses 'f.#{attribute_name} value' syntax " +
          "rather than 'f.#{attribute_name} = value'"
      end
    end

    def set_proxy_value(proxy, value)
      if @ignored
        proxy.set_ignored(self, value)
      else
        proxy.set(self, value)
      end
    end
  end
end
