require './app/controllers/concerns/obj_creation'


RSpec.describe ObjCreation do
  include ObjCreation
  describe "keyword helper method" do
    it "receives a string and puts out an array object" do
      test_string = "for the test"
      array = check_keyword(test_string)
      expect(array.class).to eq(Array)
    end

    it "creates keywords objects that respond to the method word" do
      test_string = "for the test"
      array = check_keyword(test_string)
      expect(array[0].word).to eq("for")
    end

  end



end
