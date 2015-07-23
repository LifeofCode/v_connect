# Homepage (Root path)

# TODO: authorize logged in student
helpers do
  def current_student
    Student.find(session[:id]) if session[:id]
  end
  def current_student?
    session[:id]
  end
  def current_org
    Organization.find(session[:org_id]) if session[:org_id]
  end
  def current_org?
    session[:org_id]
  end
end

get '/' do
  erb :index
end

get '/logout' do
  session[:id] = nil
  session[:org_id] = nil
  redirect '/'
end