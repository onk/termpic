module Termpic
  class AnsiRgb
    def self.wrap_with_code(string, rgb)
      red, green, blue = rgb[0], rgb[1], rgb[2]
      "\e[#{code(red, green, blue)}m" + string + "\e[0m"
    end

    def self.code(red, green, blue)
      index = 16 +
        to_ansi_domain(red) * 36 +
        to_ansi_domain(green) * 6 +
        to_ansi_domain(blue)
      "48;5;#{index}"
    end

    def self.to_ansi_domain(value)
      (6 * (value / 256.0)).to_i
    end
  end
end

