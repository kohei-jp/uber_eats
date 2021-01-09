begin
  require 'hirb'
  # これが無いとdisplay_widthが無くてエラー
  require 'unicode/display_width/string_ext'
  # これもrequireしないと勝手には反応しない
  require 'hirb-unicode'
rescue LoadError
  # hirbがrequireできないでござる
end

if defined? Hirb
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      @old_print = Pry.config.print
      Pry.config.print = proc do |*args|
        Hirb::View.view_or_page_output(args[1]) || @old_print.call(*args)
      end
    end

    def disable_output_method
      Pry.config.print = @old_print
      @output_method = nil
    end
  end

  # hirbをオフにしたい時はHirb.disableする
  Hirb.enable
end