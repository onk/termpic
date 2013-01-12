module Termpic
  class Image
    def initialize(path)
      @image = Magick::ImageList.new(path)
    end

    def draw
      cols = @image.columns
      rows = @image.rows
      ret = []
      rows.times do |y|
        cols.times do |x|
          ret[y] ||= []
          pixcel = @image.pixel_color(x, y)
          r = pixcel.red / 256
          g = pixcel.green / 256
          b = pixcel.blue / 256
          ret[y] << " ".background(r, g, b)
        end
      end
      ret.each do |row|
        puts row.join
      end
    end
  end
end

