module Administrate
  class Namespace
    class Resource
      attr_reader :namespace, :resource, :actions

      def initialize(namespace, resource, actions = [])
        @namespace = namespace
        @resource = resource
        @actions = Set.new(actions)
      end

      def to_s
        name.to_s
      end

      def to_sym
        name
      end

      def name
        resource.to_s.gsub(/^#{namespace}\//, "").to_sym
      end

      def path
        name.to_s.gsub("/", "_")
      end
    end
  end
end
