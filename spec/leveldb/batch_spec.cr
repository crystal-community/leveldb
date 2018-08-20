require "../spec_helper"

describe LevelDB::Batch do
  it "writes" do
    FileUtils.rm_r(TEST_DB) if Dir.exists?(TEST_DB)
    db = LevelDB::DB.new(TEST_DB)

    begin
      batch = LevelDB::Batch.new
      batch.put("a", "2")
      batch.put("b", "3")
      batch.put("c", "4")
      batch["d"] = "5"
      batch.delete("b")

      db.write(batch)

      db.get("b").should eq nil
      db.get("a").should eq "2"
      db.get("c").should eq "4"
      db.get("d").should eq "5"

      batch = LevelDB::Batch.new
      batch.put("a", "20")
      batch.put("b", "1")
      db.write(batch)

      db.get("b").should eq "1"
      db.get("a").should eq "20"

    ensure
      db.close
    end
  end
end
