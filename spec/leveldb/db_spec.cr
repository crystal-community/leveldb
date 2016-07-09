require "../spec_helper"

describe LevelDB do
  describe "DB" do
    it "works" do
      FileUtils.rm_r(TEST_DB) if Dir.exists?(TEST_DB)

      db = LevelDB::DB.new(TEST_DB)

      # get / put
      db.put("key", "value")
      db.get("key").should eq "value"

      # when key does not exist
      db.get("something-else").should eq nil

      # delete
      db.delete("key")
      db.get("key").should eq nil

      # Try to open already opened DB
      expect_raises(LevelDB::Error, "IO error: lock") do
        LevelDB::DB.new(TEST_DB)
      end

      # close
      db.close

      # should not raise, cause DB was closed
      db = LevelDB::DB.new(TEST_DB)
      db.close

      # destroy
      db.destroy
    end

    describe ".new" do
      context "when DB does not exist yet" do
        context "when create_if_missing = true" do
          it "opens DB" do
            db = LevelDB::DB.new(TEST_DB, create_if_missing: true)
            db.close
            db.destroy
          end
        end

        context "when create_if_missing = false" do
          it "raises exception" do
            expect_raises(LevelDB::Error, "does not exist (create_if_missing is false)") do
              db = LevelDB::DB.new(TEST_DB, create_if_missing: false)
            end
          end
        end
      end
    end

    describe "snapshots" do
      it "can create, set and unset snapshots" do
        db = LevelDB::DB.new(TEST_DB)
        db.put("aa", "11")
        db.put("bb", "22")

        snapshot = db.create_snapshot

        db.delete("aa")
        db.get("aa").should eq nil
        db.get("bb").should eq "22"

        # Set snapshot
        db.set_snapshot(snapshot)
        db.get("aa").should eq "11"
        db.get("bb").should eq "22"

        db.unset_snapshot
        db.get("aa").should eq nil
        db.get("bb").should eq "22"

        # Release snapshot
        snapshot.release
        db.set_snapshot(snapshot)
        db.get("aa").should eq nil

        db.close
      end
    end

    it "has #open/#close methods" do
      FileUtils.rm_r(TEST_DB) if Dir.exists?(TEST_DB)
      db = LevelDB::DB.new(TEST_DB)

      db.opened?.should eq true
      db.closed?.should eq false

      # Opening an opened DB should not cause exceptions
      db.open

      db.put("x", "33")

      db.close
      db.opened?.should eq false
      db.closed?.should eq true

      # Try operations on closed DB
      expect_raises(LevelDB::Error, "is closed") { db.get("x") }
      expect_raises(LevelDB::Error, "is closed") { db.put("x", "32") }
      expect_raises(LevelDB::Error, "is closed") { db.delete("x") }

      # Make sure double close does not cause exceptions
      db.close
      db.close
    end

    it "supports #[], #[]= methods" do
      FileUtils.rm_r(TEST_DB) if Dir.exists?(TEST_DB)
      db = LevelDB::DB.new(TEST_DB)
      db["name"] = "Sergey"
      db["name"].should eq "Sergey"
      db.close
    end

    describe "#each" do
      it "iterates through all the keys" do
        FileUtils.rm_r(TEST_DB) if Dir.exists?(TEST_DB)
        db = LevelDB::DB.new(TEST_DB)

        out = ""

        db.put("k1", "v1")
        db.put("k2", "v2")
        db.put("k3", "v3")

        db.each do |key, val|
          out += "#{key}=#{val};"
        end

        out.should eq "k1=v1;k2=v2;k3=v3;"

        db.close
      end
    end

    describe "#clear" do
      it "removes all the keys" do
        FileUtils.rm_r(TEST_DB) if Dir.exists?(TEST_DB)
        db = LevelDB::DB.new(TEST_DB)

        db.put("k1", "v1")
        db.put("k2", "v2")

        db.clear
        db.get("k1").should eq nil
        db.get("k2").should eq nil

        db.close
      end
    end
  end
end
