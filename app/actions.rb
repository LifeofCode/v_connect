# Homepage (Root path)

helpers do

  # check for current user
  def current_student
    @student ||= Student.find(session[:id])
  end

  def current_org
    @organization ||= Organization.find(session[:id])
  end

  def current_student?
    session[:id] && session[:type] == 'student'
  end
  
  def current_org?
    session[:id] && session[:type] == 'organization'
  end

  # redirect to profile page if user is logged in
  def logged_in!
    return if ! (current_org? || current_student?)
    redirect "/#{session[:type]}s/profile"
  end

  # set session user
  def login_user(id, type)
    session[:id] = id
    session[:type] = type
    redirect "/#{type}s/profile"
  end

  # redirect to home when a student is not logged in
  def auth_student!
    return current_student if current_student?
    redirect '/'
  end

  def auth_org!
    return current_org if current_org?
    redirect '/'
  end

end

before do
  @errors =[]
end

get '/' do
  erb :index
end

get '/logout' do
  session[:id] = nil
  session[:type] = nil
  redirect '/'
end