require "../spec_helper"

describe LevelDB::Iterator do
  it "works" do
    FileUtils.rm_r(TEST_DB) if Dir.exists?(TEST_DB)

    db = LevelDB::DB.new(TEST_DB)
    db.put("k1", "v1")
    db.put("k2", "v2")

    iterator = LevelDB::Iterator.new(db)

    iterator.seek_to_first
    iterator.key.should eq "k1"
    iterator.value.should eq "v1"

    iterator.next
    iterator.key.should eq "k2"
    iterator.value.should eq "v2"

    iterator.valid?.should eq true
    iterator.next
    iterator.valid?.should eq false

    iterator.seek_to_first
    iterator.key.should eq "k1"
    iterator.seek_to_last
    iterator.key.should eq "k2"

    iterator.destroy
    db.close
  end
end
