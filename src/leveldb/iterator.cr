module LevelDB
  class Iterator
    def initialize(@db : DB)
      @iter_ptr = LibLevelDB.leveldb_create_iterator(@db.db_ptr, @db.roptions_ptr)
    end

    def seek_to_first
      LibLevelDB.leveldb_iter_seek_to_first(@iter_ptr)
    end

    def seek_to_last
      LibLevelDB.leveldb_iter_seek_to_last(@iter_ptr)
    end

    def seek(key)
      LibLevelDB.leveldb_iter_seek(@iter_ptr, key, key.bytesize)
    end

    def valid?
      LibLevelDB.leveldb_iter_valid(@iter_ptr)
    end

    def key
      len = 0_u64
      ptr = LibLevelDB.leveldb_iter_key(@iter_ptr, pointerof(len))
      String.new(ptr, len)
    end

    def value
      len = 0_u64
      ptr = LibLevelDB.leveldb_iter_value(@iter_ptr, pointerof(len))
      String.new(ptr, len)
    end

    def next
      LibLevelDB.leveldb_iter_next(@iter_ptr)
    end

    def destroy
      LibLevelDB.leveldb_iter_destroy(@iter_ptr)
    end
  end
end
