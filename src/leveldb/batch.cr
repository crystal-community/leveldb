module LevelDB
  class Batch
    getter :batch_ptr

    def initialize
      @batch_ptr = LibLevelDB.leveldb_writebatch_create
    end

    def put(key : String, value : String)
      LibLevelDB.leveldb_writebatch_put(@batch_ptr, key, key.bytesize, value, value.bytesize)
    end

    def delete(key : String)
      LibLevelDB.leveldb_writebatch_delete(@batch_ptr, key, key.bytesize)
    end

    def destroy
      LibLevelDB.leveldb_writebatch_destroy(@batch_ptr)
    end
  end
end
