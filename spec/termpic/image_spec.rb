require "spec_helper"
describe Termpic::Image do
  describe "#initialize" do
    it { Termpic::Image.new(TermpicTestImage::SAMPLE_IMAGE_PATH).should_not be_nil }
  end
end

