module Termpic
  class Image
    def initialize(path)
      @image = Magick::ImageList.new(path)
    end

    def draw
      rgb_analyze
      ansi_analyze
      puts_ansi
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
          r, g, b = pixcel
          " ".background(r, g, b)
        }.join
      end
      @ansi = ret.join("\n")
    end

    def puts_ansi
      raise "use ansi_analyze before to_ansi" unless @ansi
      puts @ansi
    end
  end
end

