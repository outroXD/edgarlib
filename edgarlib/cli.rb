# encoding: utf-8

require 'optionparser'

module Edgarlib
  module CliTools
    class Args
      attr_accessor :is_install, :tickers

      public
      def initialize
        @tickers    ||= []
        @is_install ||= false
        parse_args
        LOGGER.info(to_s)
      end

      def to_s
        log = ""
        if @is_install
          log << "-I: #{@is_install} --install: #{@tickers}"
        end
        log.to_s
      end

      private
      def parse_args
        option_parser = OptionParser.new
        option_parser.on('-I', '--install <ticker>', 'tickerで指定したXBRLをローカルにダウンロードする。') do |v|
          @tickers.append(v.upcase)
          if @tickers.length != 0
            @is_install = true
          end
        end
        option_parser.parse(ARGV)
      end
    end
  end
end