# encoding: utf-8

require_relative 'cli'

module Edgarlib
  class Main
    def self.run
      args = Edgarlib::CliTools::parse_args
    end
  end
end


# ===== main =====
Edgarlib::Main.run