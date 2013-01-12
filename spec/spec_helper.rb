$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'termpic'

module TermpicTestImage
  sample_dir = File.expand_path(File.dirname(__FILE__) + "/sample")
  SAMPLE_IMAGE_PATH = sample_dir + "/octocat.jpg"
end
