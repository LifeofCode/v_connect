#students can see a list of all organizations that are registered
get '/organizations' do 
  #TODO: change when sessions/login/authorization is finished
  @student_favs = []
  @student_favs = current_student.organizations.map {|organization| organization.id} if current_student
  @organizations = Organization.all
  erb :'organizations/index'
end

# organization sign up page
get '/organizations/register' do
  logged_in!
  @organization = Organization.new
  erb :'organizations/new'
end

# organization login page
get '/organizations/session' do
  logged_in!
  @organization = Organization.new
  erb :'organizations/login'
end

get '/organizations/profile' do
  auth_org!
  @students = @organization.students
  erb :'/organizations/show'
end

get '/organizations/edit' do
  auth_org!
  erb :'/organizations/edit'
end

#an organization can see a list of interested students
get '/organizations/:id/students' do
  #TODO: refactor erb file using partials
  auth_org!
  @students = @organization.students
  erb :'students/index'
end

# create new organization
post '/organizations' do
  @organization = Organization.new(params[:org])
  @organization.password = params[:password]
  @organization.password_confirmation = params[:password2]
  if @organization.save
    login_user(@organization.id, 'organization')
  else
    @errors = @organization.errors.full_messages 
    erb :'organizations/new'
  end
end

# login as an organization
post '/organizations/session' do
  @org = Organization.find_by(email: params[:email])
  if @org && @org.authenticate(params[:password])
    login_user(@org.id, 'organization')
  else
    @errors << "Invalid login"
    erb :'organizations/login'
  end
end

# edit organization profile
put '/organizations' do
  auth_org!
  # TODO: clearing the name will also clear the name in the nav bar
  if @organization.update(params[:org])
    session[:name] = @organization.name
    redirect '/organizations/profile'
  else    
    @errors = @organization.errors.full_messages
    erb :'organizations/edit'
  end
end