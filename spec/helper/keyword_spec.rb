require './app/helper/job_helper'


RSpec.describe JobHelper do
  include JobHelper
  describe "keyword helper method" do
    it "receives a string and puts out an array" do
      test_string = "for the test"
      expect(check_keyword(test_string).each.word).to include({"word": "for"})

    end
  end



end
