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
  fave_band_ids = @user.bands.map(&:songkick_id)
  @bands = get_songkick_name(fave_band_ids) if fave_band_ids.length > 0
  erb :show
end

post '/users' do
  #sign-up a new user
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
  bands = init_songkick
  @bands = bands.find_artist(params[:band_name])
  band_ids = []

  if @bands && @bands["resultsPage"]["results"]
    if @bands["resultsPage"]["results"].to_s.length > 0
      @bands["resultsPage"]["results"]["artist"].map do |band|
        band_ids.push(band["id"])
      end
    end
  else
    @errors = ["band not found"]
  end

  # if band_ids.length > 0 && band_ids.length < 20
  #   @thumbnails = get_thumbnails(band_ids)
  # else
  #   shorter_band_ids = band_ids.slice(0, 15)
  #   @thumbnails = get_thumbnails(shorter_band_ids)
  # end

  @gig_count = get_gig_count(band_ids)
  erb :bands
end

post '/bands/:band_id/follow' do
  if current_user
    @user = current_user
    fav = is_fave(params[:band_id].to_i)
    if fav
      @user.unfollow(params[:band_id].to_i)
    else
      @user.follow(params[:band_id].to_i)
    end

    if request.xhr?
      # (erb :show).to_json
      #return opposite
      {status: !fav}.to_json
    else
      redirect "/bands/#{params[:band_id]}/follow"
    end
  else
    @errors = ["you need to sign up or sign in to save a favorite"]
    erb :index
  end
end


get '/bands/:band_id/follow' do
  if current_user
    @user = current_user
    fave_band_ids = @user.bands.map(&:songkick_id)
    @bands = get_songkick_name(fave_band_ids) if fave_band_ids.length > 0
    erb :show
  else
    @errors = ["you need to sign up or sign in to save a favorite"]
    erb :index
  end
end

get '/bands/:band_id' do
  @band = get_songkick_name([params[:band_id]]).first
  band_events = get_events(@band.display_name)
  @events = band_events.results
  if current_user
    @fav = is_fave(@band.id)
    erb :show_band
  else
    @errors = ["you need to sign up or sign in to save a favorite"]
    erb :index
  end
end
