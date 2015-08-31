helpers do

  #give_token in the bcrypt doc
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def check_length(password)
    password.length >= 6
  end

  def create
    @user = User.new(username: params[:username], email: params[:email])
    @user.password = params[:password]
    @user.save
  end


  def log_out
    session[:user_id] = nil
    @current_user = nil
  end

  def find_user_id
    @user = User.find(session[:user_id])
  end

end
