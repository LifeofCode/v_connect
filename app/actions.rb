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
    @student = nil
    return if ! (current_org? || current_student?)
    redirect "/#{session[:type]}s/profile"
  end

  # set session user
  def login_user(id, type)
    session[:id] = id
    session[:type] = type
    # TODO: find a better way to save session user info (for nav bar)
    session[:name] = current_student.first_name if current_student?
    session[:name] = current_org.name if current_org?
    redirect "/#{type}s/profile"
  end

  def session_name
    session[:name]
  end

  # redirect to login page
  def auth_student!
    return current_student if current_student?
    redirect '/students/session'
  end

  def auth_org!
    return current_org if current_org?
    redirect '/organizations/session'
  end

  def check_favourites
    @student_favs = Favourite.where(student_id: current_student.id).pluck(:organization_id)
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