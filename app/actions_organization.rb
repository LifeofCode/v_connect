#students can see a list of all organizations that are registered
get '/organizations' do 
  #TODO: change when sessions/login/authorization is finished
  @organizations = Organization.all
  erb :'organizations/index'
end

# organization sign up page
get '/organizations/register' do
  @organization = Organization.new
  @errors = [] #TODO: create a helper for checking errors
  erb :'organizations/new'
end

# organization login page
get '/organizations/session' do
  @organization = Organization.new
  @errors = []
  erb :'organizations/login' #TODO: combine this with the student login
end

get '/organizations/profile' do
  @organization = Organization.find(session[:org_id])
  if @organization
    erb :'/organizations/show'
  else 
    redirect '/'
  end
end

#an organization can see a list of interested students
get '/organizations/:id/students' do
  #TODO: refactor erb file using partials
  @organization = Organization.find(params[:id])
  @students = @organization.students
  erb :'students/index'
end

# create new organization
post '/organizations' do
  @errors = []
  @organization = Organization.new(params[:org])
  @organization.password = params[:password]
  @organization.password_confirmation = params[:password2]
  if @organization.save
    session[:org_id] = @organization.id
    redirect '/organization/profile'
  else
    @errors = @organization.errors.full_messages 
    erb :'organizations/new'
  end
end

# login as an organization
post '/organizations/session' do
  @org = Organization.find_by(email: params[:email])
  @errors = []
  if @org && @org.authenticate(params[:password])
    session[:org_id] = @org.id
    redirect '/organizations/profile'
  else
    @errors << "Invalid login"
    erb :'organizations/login'
  end
end