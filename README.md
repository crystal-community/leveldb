# LevelDB <img src="https://raw.githubusercontent.com/crystal-community/leveldb/master/images/crystal-leveldb-logo2.png" alt="crystal levedb" width="48">

Crystal binding for [LevelDB](https://github.com/google/leveldb).

[![Build Status](https://travis-ci.org/crystal-community/leveldb.svg?branch=master)](https://travis-ci.org/crystal-community/leveldb)

> LevelDB is a fast key-value storage library written at Google that provides an ordered mapping from string keys to string values.

## Installation

### Prerequisites

Debian:
```
sudo apt-get install libleveldb-dev libleveldb1v5 libsnappy1v5
```

### shard.yml

```yaml
dependencies:
  leveldb:
    github: "crystal-community/leveldb"
    version: "~> 0.3.0"
```

## Usage

### Basic usage

```crystal
require "leveldb"

# Create DB (if does not exist yet) and open
db = LevelDB::DB.new("./db")

# Put, get, delete
db.put("name", "Sergey")
db.get("name")  # => "Sergey"
db.delete("name")
db.get("name")  # => nil

# [], []= methods work the same
db["city"] = "Berlin"
db["city"]  # => "Berlin"

# Iterate through all the keys
db.each do |key, val|
  puts "#{key} = #{val}"
end

# Close database
db.close
db.closed? # => true
db.opened? # => false

# Close the database and remove all the data
db.destroy

# Remove all the keys, keep the database open
db.clear
```

### Batches 
> Apply a atomic batch of of operation to the key-value store.

```crystal
require "leveldb"

db = LevelDB::DB.new("./db")
begin
  batch = LevelDB::Batch.new

  batch.put("name","Martin")
  batch.put("age","25")
  batch.put("location","Bariloche")
  batch.delete("age")

  # write batch to the db in atomic way
  db.write(batch)

  puts db.get("name")
  puts db.get("age") # nil
  puts db.get("location")
ensure
  # free memory 
  batch.destroy 
  # close the database
  db.close
end


```

### Snapshots

> Snapshots provide consistent read-only views over the entire state of the key-value store.

```crystal
db = LevelDB::DB.new("./db")

db.put("a", "1")
db.get("a")  # => "1"

snapshot = db.create_snapshot
db.delete("a")
db.get("a")  # => nil

db.set_snapshot(snapshot)
db.get("a")  # => "1"

db.unset_snapshot
db.get("a")  # => nil
```


## Performance

There is performance comparison of LevelDB and other stores from
[Kiwi](https://github.com/greyblake/crystal-kiwi#performance-porn) project.

![LevelDB VS other storages](https://sc-cdn.scaleengine.net/i/8a5361ab85b005f7bfb6ed7941b4a5ef.jpg)

## Contributors

- [greyblake](https://github.com/greyblake) Sergey Potapov - creator, maintainer
- [twisterghost](https://github.com/twisterghost) Michael Barrett
