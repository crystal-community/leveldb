module LevelDB
  class Snapshot
    getter :db, :__ptr

    def initialize(@db : DB, @__ptr : Pointer(Void))
    end

    def release
      LibLevelDB.leveldb_release_snapshot(@db.db_ptr, @__ptr)
    end

    def finalize
      LibLevelDB.leveldb_free(@__ptr)
    end
  end
end
