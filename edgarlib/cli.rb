# encoding: utf-8

require 'optionparser'

class CliTools
  def parse_args
    options = Hash.new(false)
    option_parser = OptionParser.new
    option_parser.on('-T') {|v| options[:T] = true}
    option_parser.on('-I') {|v| options[:I] = true}
    option_parser.parse(ARGV)

    options
  end
end