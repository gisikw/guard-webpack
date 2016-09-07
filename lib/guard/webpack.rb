module Guard
  class Webpack < ::Guard.const_get(::Guard.const_defined?(:Plugin) ? :Plugin : :Guard)
    require 'guard/webpack/version'
    require 'guard/webpack/runner'

    DEFAULT_OPTIONS = {
      d:        false,
      progress: true,
      colors:   true
    }

    attr_accessor :runner

    def initialize(*args)
      with_defaults(args[-1]) do |opts|
        super(opts)
        @runner = Runner.new(opts)
      end
    end

    def run_on_modifications(p);  @runner.restart;  end
    def run_all;                  @runner.start;    end
    def reload;                   @runner.restart;  end
    def start;                    @runner.start;    end
    def stop;                     @runner.stop;     end

    private

    def with_defaults(options)
      yield DEFAULT_OPTIONS.merge(options)
    end

  end
end
