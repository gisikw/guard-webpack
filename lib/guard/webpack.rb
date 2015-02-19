require 'guard/webpack/version'
require 'guard/webpack/runner'

module Guard
  class Webpack < Guard::Plugin

    DEFAULT_OPTIONS = {
      progress: true,
      colors:   true
    }

    attr_accessor :runner

    def initialize(options = {})
      with_defaults(options) do |opts|
        super(opts)
        @runner = Runner.new(opts)
      end
    end

    def run_on_modifications(p);  @runner.restart;  end
    def run_all;                  @runner.restart;  end
    def reload;                   @runner.retart;   end
    def start;                    @runner.start;    end
    def stop;                     @runner.stop;     end

    private

    def with_defaults(options)
      yield DEFAULT_OPTIONS.merge(options)
    end

  end
end
