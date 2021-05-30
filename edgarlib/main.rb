# encoding: utf-8

require_relative 'cli'

class Edgarlib
  def run
    args = CliTools.new.parse_args
  end
end


# ===== main =====
main_obj = Edgarlib.new
main_obj.run