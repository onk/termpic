require "io/console"
module Termpic
  class Image
    def initialize(path, options = {})
      @image = Magick::ImageList.new(path)
      @fit_terminal = !!options[:fit_terminal]
      @show_size = !!options[:show_size]
      @double = !!options[:double]
      @path = path
      @domain = options[:domain]
    end

    def draw
      convert_to_fit_terminal_size if @fit_terminal
      rgb_analyze
      ansi_analyze
      puts_ansi
      puts_size if @show_size
      puts_url if @domain
    end

    def convert_to_fit_terminal_size
      term_height, term_width = IO.console.winsize
      term_width = term_width / 2 if @double
      @orig_image = @image
      @image = @image.resize_to_fit(term_width, term_height)
    end

    def rgb_analyze
      @rgb = []
      cols = @image.columns
      rows = @image.rows
      rows.times do |y|
        cols.times do |x|
          @rgb[y] ||= []
          pixcel = @image.pixel_color(x, y)
          r = pixcel.red / 256
          g = pixcel.green / 256
          b = pixcel.blue / 256
          @rgb[y] << [r, g, b]
        end
      end
    end

    def ansi_analyze
      raise "use rgb_analyze before ansi_analyze" unless @rgb
      ret = []
      @rgb.map! do |row|
        ret << row.map{|pixcel|
          AnsiRgb.wrap_with_code(@double ? "  " : " ", pixcel)
        }.join
      end
      @ansi = ret.join("\n")
    end

    def puts_ansi
      raise "use ansi_analyze before to_ansi" unless @ansi
      puts @ansi
    end

    def puts_size
      if @orig_image
        puts "#{@orig_image.columns}x#{@orig_image.rows}"
      else
        puts "#{@image.columns}x#{@image.rows}"
      end
    end

    def puts_url
      public_marker_dirs = ["public", "assets"]
      full_path = File.absolute_path(@path)
      dirs = full_path.split(File::SEPARATOR)
      idx = dirs.rindex{|dir| public_marker_dirs.include?(dir) }
      case dirs[idx]
      when "public"
        puts "http://#{@domain}/#{dirs[idx+1 .. -1].join("/")}"
      when "assets"
        puts "http://#{@domain}/#{dirs[idx .. -1].join("/")}"
      end
    end
  end
end

