helpers do

  #give_token in the bcrypt doc
  def log_in(user)
    session[:user_id] = user.id
  end

  def create
    @user = User.new(params[:user])
    @user.password = params[:password]
    @user.save
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def log_out
    session[:user_id] = nil
    @current_user = nil
  end

end
