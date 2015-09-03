require 'songkickr'
require 'dotenv'
Dotenv.load
require 'httparty'


get '/' do
  if session[:user_id]
    find_user_id
    redirect "/users/#{session[:user_id]}"
  else
    erb :index
  end
end

#----------- SESSIONS -----------

get '/sessions/new' do
  erb :sign_in
end

post '/sessions' do
  @user = User.where(email: params[:email]).first
  if @user && @user.password == params[:password]
    log_in(@user)
    redirect "/users/#{@user.id}"
  else
    @errors = ["check username and password"]
    erb :sign_in
  end
end

get '/sessions/:id' do
  log_out
  redirect '/'
end

#----------- USERS -----------
get '/users/new' do
  erb :sign_up
end

get '/users/:user_id' do
  @user = current_user
  erb :show
end


post '/users' do
  # sign-up a new user
  #see helper method
  if check_length(params[:password])
    create
    if @user.save
      log_in(@user)
      redirect "/users/#{@user.id}"
    else
      @errors = @user.errors.full_messages
      erb :sign_up
    end
  else
    @errors = ["password should be more than 6 characters"]
    erb :sign_up
  end

end

#----------- BANDS -----------

get '/bands' do
  erb :bands
end

post '/bands' do
  band_name = params[:search_band]
  @bands = HTTParty.get("http://api.songkick.com/api/3.0/search/artists.json?query=#{band_name}&apikey=#{ENV['SONGKICK_KEY']}").to_hash
  erb :bands
end

get '/bands/:band_id/follow' do
  @user = current_user
  @band = Band.find(params[:band_id])
  @user.follow @band
  erb :show
end

get '/bands/:band_id' do
  query = Songkickr::Remote.new ENV['SONGKICK_KEY']
  @band = query.artist(params[:band_id])
  p @band
  @events = query.events(@band.display_name)
  p "*" * 80
  p @events
  erb :show_band
end


