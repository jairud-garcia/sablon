# -*- coding: utf-8 -*-
module Sablon
  module Statement
    class Insertion < Struct.new(:expr, :field, :errors)
      def evaluate(env)
        content = expr.evaluate(env.context)
        if !content.nil?
          field.replace(Sablon::Content.wrap(content), env)
        else
          field.remove
        end
      end
    end

    class Loop < Struct.new(:list_expr, :iterator_name, :block, :errors)
      def evaluate(env)
        value = list_expr.evaluate(env.context)
        value = value.to_ary if value.respond_to?(:to_ary)
        unless value.is_a?(Enumerable)
          errors<<{expression: list_expr.inspect, message: 'NotEnumerable'}
          raise ContextError, "The expression #{list_expr.inspect} should evaluate to an enumerable but was: #{value.inspect}" 
        end

        content = value.flat_map do |item|
          iter_env = env.alter_context(iterator_name => item)
          block.process(iter_env)
        end
        block.replace(content.reverse)
      end
    end

    class Condition < Struct.new(:conditon_expr, :block, :predicate, :errors)
      def evaluate(env)
        value = conditon_expr.evaluate(env.context)
        if truthy?(predicate ? value.public_send(predicate) : value)
          block.replace(block.process(env).reverse)
        else
          block.replace([])
        end
      end

      def truthy?(value)
        case value
        when Array;
          !value.empty?
        else
          !!value
        end
      end
    end

    class Comment < Struct.new(:block,:errors)
      def evaluate(_env)
        block.replace []
      end
    end

    class Image < Struct.new(:image_reference, :block, :errors)
      def evaluate(env)
        image = image_reference.evaluate(env.context)
        block.replace([image])
      end
    end
  end

  module Expression
    class Variable < Struct.new(:name)
      def evaluate(context)
        case context
        when Hash
          context[name] 
        else
          context.public_send name if context.respond_to?(name)
        end
      end

      def inspect
        "«#{name}»"
      end
    end

    class LookupOrMethodCall < Struct.new(:receiver_expr, :expression)
      def evaluate(context)
        if receiver = receiver_expr.evaluate(context)
          expression.split(".").inject(receiver) do |local, m|
            MergeableHash.new(local)[m]
          end
        end
      end

      def evaluate_receiver_expr(context)
        if expression.include?(".")
          parts = expression.split(".")
          LookupOrMethodCall.new(receiver_expr, parts.first).evaluate(context)
        end
      end

      def inspect
        "«#{receiver_expr.name}.#{expression}»"
      end
    end

    def self.parse(expression)
      if expression.include?(".")
        parts = expression.split(".")
        LookupOrMethodCall.new(Variable.new(parts.shift), parts.join("."))
      else
        Variable.new(expression)
      end
    end
  end
end
