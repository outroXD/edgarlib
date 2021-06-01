# encoding: utf-8

require 'optionparser'

module Edgarlib
  module CliTools
    class Args
      attr_accessor :ticker_cid, :install_xbrl

      public
      def initialize
        super
        self.parse_args
        LOGGER.info(self.to_s)
      end

      def to_s
        "ticker_cid: #{self.ticker_cid} install_xbrl: #{self.install_xbrl}"
      end

      private
      def parse_args
        option_parser = OptionParser.new
        option_parser.on('-T') {|v| self.ticker_cid = true}
        option_parser.on('-I') {|v| self.install_xbrl = true}
        option_parser.parse(ARGV)
      end
    end
  end
end