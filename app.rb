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

post '/personaldetails' do
	name = params[:name]
	age = params[:age]
	first_favorite_number = params[:first_favorite_number]
	second_favorite_number = params[:second_favorite_number]
	third_favorite_number = params[:third_favorite_number]
	favorite_food = params[:favorite_food]
	favorite_phrase = params[:favorite_phrase]
	favorite_color = params[:favorite_color]
	favorite_season = params[:favorite_season]
	db.exec("INSERT INTO personaldetails(name, age, first_favorite_number, second_favorite_number, third_favorite_number, favorite_food, favorite_phrase, favorite_color, favorite_season) VALUES('#{name}', '#{age}', '#{first_favorite_number}', '#{second_favorite_number}', '#{third_favorite_number}', '#{favorite_food}', '#{favorite_phrase}', '#{favorite_color}', '#{favorite_season}')");
	redirect '/'
end