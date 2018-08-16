require "../spec_helper"

describe LevelDB::Batch do
  it "writes" do
    FileUtils.rm_r(TEST_DB) if Dir.exists?(TEST_DB)
    db = LevelDB::DB.new(TEST_DB)

    batch = LevelDB::Batch.new
    batch.put("a", "2")
    batch.put("b", "3")
    batch.put("c", "4")
    batch.put("d", "5")
    batch.delete("b")

    db.write(batch)

    db.get("b").should eq nil
    db.get("a").should eq "2"
    db.get("c").should eq "4"
    db.get("d").should eq "5"

    db.close
  end
end
