# frozen_string_literal: true

module RuboCop
  module Cop
    module Security
      class ExplicitEnvVars < Base
        MSG = "Set ENV variables explicity."

        def_node_matcher :fetching_with_string_default?, <<~PATTERN
          (send (const $... :ENV) :fetch (str $...) (str $...))
        PATTERN

        def_node_matcher :fetching_with_block_default?, <<~PATTERN
          (block (send (const $... :ENV) :fetch (str $...)) (args) (str $...))
        PATTERN

        def_node_matcher :brackets_with_or?, <<~PATTERN
          (or (send (const $... :ENV) :[] (str $...)) (str $...))
        PATTERN

        def on_send(node)
          # require 'pry'; binding.pry
          return unless fetching_with_string_default?(node) || brackets_with_or?(node.parent) || fetching_with_block_default?(node.parent)

          add_offense(node)
        end
      end
    end
  end
end
