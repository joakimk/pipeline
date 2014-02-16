desc "Deploy"
task :deploy do
  system("git push heroku && heroku run rake db:migrate")
end

