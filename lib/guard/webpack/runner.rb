class Guard::Webpack::Runner
  attr_accessor :options, :thread

  def initialize(options)
    @options = options
  end

  def restart; stop; start; end

  def start
    unless_running do
      @thread = Thread.new { run_webpack }
      ::Guard::UI.info "Webpack watcher started."
    end
  end

  def stop
    if_running do
      @thread.kill
      ::Guard::UI.info "Webpack watcher stopped."
    end
  end

  private

  def local_webpack
    bin = File.join(Dir.pwd,'node_modules/webpack/bin/webpack.js')
    File.exists?(bin) && bin
  end

  def global_webpack
    system("command -v webpack >/dev/null") && 'webpack'
  end

  def no_webpack
    # TODO: This is a bad error.
    raise 'Webpack binary not found'
  end

  def webpack_bin
    local_webpack || global_webpack || no_webpack
  end

  def option_flags
    output = ""
    output += " -d"         if @options[:d]
    output += " --colors"   if @options[:colors]
    output += " --progress" if @options[:progress]
    output += " --config #{@options[:config]}" if @options[:config]
    output += " --mode #{@options[:mode]}" if @options[:mode]
    output
  end

  def run_webpack
    begin
      pid = fork{ exec("#{webpack_bin} --watch #{option_flags}") }
      Process.wait(pid)
    rescue
      # TODO: Be more discerning.
      ::Guard::UI.error "Webpack unable to start (are you sure it's installed?)"
    ensure
      Process.kill('TERM',pid)
    end
  end

  def unless_running
    yield if !@thread || !@thread.alive?
  end

  def if_running
    yield if @thread && @thread.alive?
  end

end
