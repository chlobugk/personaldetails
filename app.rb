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

post '/update' do
	new_fav = params[:new_fav]
	old_fav = params[:old_fav]
	row = params[:fav]

	case row
	when '1'
		db.exec("UPDATE personaldetails SET name = '#{new_fav}' WHERE name = '#{old_fav}' ");
	when '2'
		db.exec("UPDATE personaldetails SET age = '#{new_fav}' WHERE name = '#{old_fav}' ");
	when '3'
		db.exec("UPDATE personaldetails SET first_favorite_number = '#{new_fav}' WHERE name = '#{old_fav}' ");
	when '4'
		db.exec("UPDATE personaldetails SET second_favorite_number = '#{new_fav}' WHERE name = '#{old_fav}' ");
	when '5'
		db.exec("UPDATE personaldetails SET third_favorite_number = '#{new_fav}' WHERE name = '#{old_fav}' ");
	when '6'
		db.exec("UPDATE personaldetails SET favorite_food = '#{new_fav}' WHERE name = '#{old_fav}' ");
	when '7'
		db.exec("UPDATE personaldetails SET favorite_phrase = '#{new_fav}' WHERE name = '#{old_fav}' ");
	when '8'
		db.exec("UPDATE personaldetails SET favorite_color = '#{new_fav}' WHERE name = '#{old_fav}' ");
	when '9'
		db.exec("UPDATE personaldetails SET favorite_season = '#{new_fav}' WHERE name = '#{old_fav}' ");
	end
	redirect '/'
end







