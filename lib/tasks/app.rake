DUMP_PATH = "/tmp/pipeline_prod_db.dump"

namespace :app do
  desc "Reset development database from a production dump"
  task :reset => [:dump_db, :download_db, :import_db, :"db:migrate", :"db:test:prepare"] do
    puts "Done!"
  end

  desc "Dump the production DB"
  task :dump_db do
    system("heroku pgbackups:capture --expire") || exit(1)
  end

  # https://devcenter.heroku.com/articles/heroku-postgres-import-export
  desc "Download the production dump"
  task :download_db do
    system("curl", "--output", DUMP_PATH, `heroku pgbackups:url`) || exit(1)
  end

  desc "Import the downloaded dump"
  task :import_db => [:"db:drop", :"db:create"] do
    if ENV["DEVBOX"]
      ENV["PGPASSWORD"] = "dev"
      opts = "--host localhost --port $(service_port postgres) --user postgres"
    else
      opts = ""
    end

    system(%{pg_restore --no-acl --no-owner -d pipeline_development #{opts} "#{DUMP_PATH}"}) || exit(1)
  end
end
