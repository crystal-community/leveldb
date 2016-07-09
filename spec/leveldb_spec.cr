require "./spec_helper"


describe LevelDB do
  describe "DB" do
    it "works" do
      FileUtils.rm_r(TEST_DB) if Dir.exists?(TEST_DB)

      db = LevelDB::DB.new(TEST_DB)

      # get / put
      db.put("key", "value")
      db.get("key").should eq "value"

      # when key does not exist
      db.get("something-else").should eq ""
    end
  end
end
