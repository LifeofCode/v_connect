# Homepage (Root path)

# TODO: authorize logged in student
helpers do
  def current_student
    Student.find(session[:id]) if session[:id] && session[:type] == 'student' 
  end
  
  def current_org
    Organization.find(session[:id]) if session[:id] && session[:type] == 'organization'
  end
  
  def current_student?
    session[:id] && session[:type] == 'student'
  end
  
  def current_org?
    session[:id] && session[:type] == 'organization'
  end

  def auth_student!
    return if current_student?
    redirect '/'
    # headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    # halt 401, "Not authorized\n"
  end

  def auth_org!
    return if current_org?
    redirect '/'
  end

end

before '/*' do
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