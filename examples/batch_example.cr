require "../src/leveldb"

db = LevelDB::DB.new("/tmp/leveldb_example_batch")
begin
  # insert a location with id 'b'
  db.put("loc:b", "Bariloche, Argentina")

  batch = LevelDB::Batch.new
  # Execute a batch of atomic operations to create a whole entity with ID 1
  batch.put("obj:1:name", "Martin")
  batch.put("obj:1:age", "25")
  batch.put("obj:1:location", "b")
  # update a index at the same time of entities living in a location b
  batch.put("iloc:b:1", "")
  db.write(batch)

  batch2 = LevelDB::Batch.new
  # Execute a batch2 of atomic operations to create a whole entity with ID 2
  batch2.put("obj:2:name", "Florencia")
  batch2.put("obj:2:age", "30")
  batch2.put("obj:2:location", "b")
  # update a index at the same time of entities living in a location b
  batch2.put("iloc:b:2", "")
  db.write(batch2)

  # search all people living in location b
  iter = LevelDB::Iterator.new(db)
  city = db.get("loc:b")
  begin
    iter.seek("iloc:b")
    while iter.valid?
      # iterate until out of the index iloc:b
      kparts = iter.key.to_s.split(":")
      if kparts[0] != "iloc" || kparts[1] != "b"
        break
      end

      puts "Person with id:#{kparts[2]} lives in: #{city}"
      iter.next
    end
  ensure
    iter.destroy
  end
ensure
  db.close
  db.destroy
end
