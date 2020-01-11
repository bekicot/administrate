module Administrate
  class Namespace
    def initialize(namespace)
      @namespace = namespace
    end

    def resources
      return @resources if @resources

      _resources = {}
      _path = 0
      _action = 1
      routes.each do |route|
        if _resources[route[_path]].present?
          _resources[route[_path]].actions << route[_action]
        else
          _resources[route[_path]] =
            Resource.new(namespace, route[_path], [route[_action]])
        end
      end

      @resources = _resources.values
    end

    def routes
      @routes ||= all_routes.select do |controller, _action|
        controller.starts_with?("#{namespace}/")
      end.map do |controller, action|
        [controller.gsub(/^#{namespace}\//, ""), action]
      end
    end

    private

    attr_reader :namespace

    def all_routes
      Rails.application.routes.routes.map do |route|
        route.defaults.values_at(:controller, :action).map(&:to_s)
      end
    end
  end
end
