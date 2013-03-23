# coding: utf-8

class CommandParamsBase

  def initialize args
    @args = args
  end

  # 引数を解析する
  def parse
    validate_args
    do_parse
  end

  protected
  def validate_args
  end

  def do_parse
  end
end

class CommandBase

  COMMAND_PARAM_CLASS = CommandParamsBase

  def initialize args
    log_name = File.join(Rails.root, 'log', '%s.log' % self.class.name)
    @logger = ActiveSupport::BufferedLogger.new(log_name)
    parse_args args
  end

  def execute
    @logger.info "START %s" % self.class.name
    do_execute
    @logger.info "END %s" % self.class.name
  end

  protected
  def do_execute
  end

  def parse_args args
    @params = self.class::COMMAND_PARAM_CLASS.new(args)
    @params.parse
  end
end
