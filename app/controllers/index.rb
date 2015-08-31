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
    p "***********"
    p @user
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
  create #see helper method
  if @user.save
    log_in(@user)
    redirect "/users/#{@user.id}"
  else
    @errors = @user.errors.full_messages
    erb :sign_up
  end
end

#----------- BANDS -----------

get '/bands' do
  @bands = Band.all
  erb :bands
end

get '/bands/:band_id/follow' do
  @user = current_user
  @band = Band.find(params[:band_id])
  @user.follow @band
  erb :show
end

get '/bands/:band_id' do
  @band = Band.find(params[:band_id])
  erb :show_band
end


