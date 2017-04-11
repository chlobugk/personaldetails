require 'sinatra'
require 'pg'
load './local_env.rb' if File.exists?('./local_env.rb')
db_params = {
    host: ENV['host'],
    port: ENV['port'],
    dbname: ENV['db_name'],
    user: ENV['user'],
    password: ENV['password']
}

db = PG::Connection.new(db_params)

get '/' do 
	personaldetails=db.exec("SELECT name, age, first_favorite_number, second_favorite_number, third_favorite_number, favorite_food, favorite_phrase, favorite_color, favorite_season FROM personaldetails");
	erb :index, locals: {personaldetails: personaldetails}
end