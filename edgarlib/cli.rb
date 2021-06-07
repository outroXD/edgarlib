# encoding: utf-8

require 'optionparser'

module Edgarlib
  module CliTools
    class Args
      attr_accessor :t, :i, :tickers

      public
      def initialize
        self.tickers = []
        self.parse_args
        LOGGER.info(self.to_s)
      end

      def to_s
        "-T: #{self.t} -I: #{self.i}"
      end

      private
      def parse_args
        option_parser = OptionParser.new
        option_parser.on('-T') {|v| self.t = true}
        option_parser.on('-I', '--install <ticker>', 'tickerで指定したXBRLをローカルにダウンロードする。') do |v|
          self.i = true
          self.tickers.append(v.upcase)
        end
        option_parser.parse(ARGV)
      end
    end
  end
end