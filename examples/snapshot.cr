require "../src/leveldb"

db = LevelDB::DB.new("/tmp/leveldb_example_snapshot")

db.put("a", "1")
pp db.get("a")

snapshot = db.create_snapshot
db.delete("a")
pp db.get("a")

puts "With snapshot"
db.set_snapshot(snapshot)
pp db.get("a")
db.put("b", "2")

puts "Without snapshot"
db.unset_snapshot

db.delete("a")
pp db.get("a")
pp db.get("b")

puts "With snapshot again"
db.set_snapshot(snapshot)
pp db.get("a")

db.close
