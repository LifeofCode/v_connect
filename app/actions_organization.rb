#students can see a list of all organizations that are registered
get '/organizations' do 
  auth_student!
  check_favourites
  @organizations = Organization.all
  erb :'organizations/index'
end

# student can search for organization by name
get '/organizations/search' do
  check_favourites
  redirect '/organizations' if params[:keyword].empty?
  @organizations = Organization.where("lower(name) LIKE ?", "%#{params[:keyword].downcase}%")
  if @organizations.empty?
    @errors << "Cannot find organization with #{params[:keyword]}"
    @organizations = Organization.all
  end
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
  @organization = current_org
  @students = current_org.students
  @opportunities = current_org.opportunities
  erb :'/organizations/show'
end

get '/organizations/edit' do
  auth_org!
  erb :'/organizations/edit'
end



# list opportunities by organization
get '/organizations/opportunities' do
  auth_org!
  @organization = current_org
  @opportunities = current_org.opportunities
  erb :'/opportunities/index'
end

get '/organizations/:id' do
  @organization = Organization.find(params[:id])
  @opportunities = @organization.opportunities
  erb :'organizations/show'
end


get '/organizations/opportunities/new' do
  auth_org!
  erb :'/opportunities/new'
end

get '/organizations/opportunities/:id' do 
  @opportunity = Opportunity.find(params[:id])
  @organization = @opportunity.organization
  erb :'opportunities/show'
end

get '/organizations/opportunities/:id/edit' do
    @opportunity = Opportunity.find_by(id: params[:id])
    erb :'opportunities/edit'
end


get '/organizations/opportunities/:id/delete' do
  @opportunity = Opportunity.find_by(id: params[:id])
  @opportunity.delete
  redirect '/organizations/opportunities'
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



post '/organizations/opportunities/new' do
    @opportunity = Opportunity.new
    @opportunity.title = params[:title]
    @opportunity.content = params[:content]
    @opportunity.organization_id = current_org.id
    @organization = current_org

  if @opportunity.save
    redirect '/organizations/opportunities'
  else
    @errors = @opportunity.errors.full_messages 
    erb :'opportunities/new'
  end
end


post '/organizations/opportunities/:id/edit' do
    @opportunity = Opportunity.find_by(id: params[:id])
    @opportunity.title = params[:title]
    @opportunity.content = params[:content]
    @opportunity.organization_id = current_org.id

  if @opportunity.save
    redirect '/organizations/opportunities'
  else
    @errors = @opportunity.errors.full_messages 
    erb :'opportunities/edit'
  end
end

# edit organization profile

put '/organizations' do
  auth_org!
  if @organization.update(params[:org])
    session[:name] = @organization.name
    redirect '/organizations/profile'
  else    
    @errors = @organization.errors.full_messages
    erb :'organizations/edit'
  end
end 


