# Homepage (Root path)

# TODO: authorize logged in student
helpers do

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
  # save current_student to @student otherwise
  def auth_student!
    return if current_student?
    redirect '/'
  end

  def auth_org!
    return if current_org?
    redirect '/'
  end

end

before do
  # TODO: before every route seems excessive
  @errors =[]
  @student = Student.find(session[:id]) if current_student?
  @organization = Organization.find(session[:id]) if current_org?
end

get '/' do
  erb :index
end

get '/logout' do
  session[:id] = nil
  session[:type] = nil
  redirect '/'
end