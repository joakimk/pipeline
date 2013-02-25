# Ensures tests are marked up correctly as :db specs where needed. Runs
# everythings else within spec/ as nulldb.
module RspecNulldb
  def self.setup(config)
    config.before(:each) do
      $nulldb = true
    end

    config.before(:each, :db) do
      $nulldb = false
    end

    config.before(:each) do
      if $nulldb
        ActiveRecord::Base.establish_connection adapter: :nulldb
      else
        ActiveRecord::Base.establish_connection :test
      end
    end
  end
end

module ActiveRecord
  module ConnectionAdapters
    module DatabaseStatements
      alias_method :orig_to_sql, :to_sql
      def to_sql(arel, binds = [])
        if $nulldb
          raise "You're trying to use the database in this test but it's not marked with :db"
        end

        orig_to_sql(arel, binds)
      end
    end
  end
end
