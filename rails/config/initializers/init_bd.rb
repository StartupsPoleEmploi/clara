# puts "hello - - - - - - - - - - - - - - - - - - - - - - - - - "

# unless ActiveRecord::Base.connection.table_exists? 'aids'
#   puts "table aids do not exists - - - - - - - - - - - - - - - "
#   system "rake db:create"
#   system "rake db:migrate"
#   system "rake db:seed"
#   # system "pg_restore --verbose --clean --no-acl --no-owner -h localhost -d ara_dev #{Rails.root}/db/local.dump"
# end
