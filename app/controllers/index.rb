get '/' do
  if session[:user_id]
    @user = User.find(session[:user_id])
    redirect "/users/#{session[:user_id]}"
  else
    erb :index
  end
end

#----------- SESSIONS -----------

get '/sessions/new' do
  erb :sign_in
end

post '/session' do
  @user = User.find_by(email: params[:session][:email])
  if @user && @user.password == params[:password]
    log_in(@user)
    redirect "/users/#{@user.id}"
  else
    @errors = @user.errors
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
  @user = User.find(session[:user_id])
  erb :show
end


post '/users' do
  # sign-up a new user
  create #see helper method
  if @user.save
    log_in(@user)
    redirect '/'
  else
    @errors = @user.errors
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


