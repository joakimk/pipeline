# Prevents you from accidentally running a DB-only test as part of the
# default memory-only test suite. Ensures tests are marked up correctly
# as :ar specs where needed.
module DatabaseAccessFilter
  def self.setup(config)
    running_tests_with_database_integration = ENV['DB']
    running_a_single_file = (ARGV.count == 1)

    config.before(:each, :ar) do
      $nulldb = false
      ActiveRecord::Base.establish_connection :test
    end

    unless running_tests_with_database_integration
      config.filter_run_excluding(:ar) unless running_a_single_file
      $nulldb = true
      ActiveRecord::Base.establish_connection adapter: :nulldb
    end
  end
end

module ActiveRecord
  module ConnectionAdapters
    module DatabaseStatements
      alias_method :orig_to_sql, :to_sql
      def to_sql(arel, binds = [])
        if $nulldb
          raise "You're trying to use the database in this test but it's not marked with :ar and DB is not set."
        end

        orig_to_sql(arel, binds)
      end
    end
  end
end
