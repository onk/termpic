module Termpic
  class Image
    def initialize(path)
      @image = Magick::ImageList.new(path)
    end
  end
end

