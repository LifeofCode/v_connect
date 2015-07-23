#display all students that are registered
get '/students' do 
  @errors = []
  @students = Student.all
  erb :'students/index'
end

# student sign up page
get '/students/register' do
  @student = nil
  @errors = [] #TODO: create a helper for checking errors
  erb :'students/new'
end

# student login page
get '/students/session' do
  @student = nil
  @errors = []
  erb :'students/login'
end

#a student can see their favourite organizations
get '/students/:id/organizations' do
  @errors = []
  @student = Student.find(params[:id])
  @organizations = @student.organizations
  erb :'organizations/index'
end

# create new student
post '/students' do
  @errors = []
  @student = Student.new(params[:student])
  @student.password = params[:password]
  @student.password_confirmation = params[:password2]
  if @student.save
    session[:id] = @student.id
    redirect '/students/profile'
  else
    @errors = @student.errors.full_messages 
    @student = nil
    erb :'students/new'
  end
end

# login student
post '/students/session' do
  @student = Student.find_by(email: params[:email])
  @errors = []
  if @student && @student.authenticate(params[:password])
    session[:id] = @student.id
    redirect '/students/profile'
  else
    @student = nil
    @errors << "Invalid login"
    erb :'students/login'
  end
end

get '/students/profile' do
  @student = Student.find_by(id: session[:id])
  if @student
    erb :'/students/show'
  else redirect '/'
  end
end

post '/favourite' do 
  fav_found = Favourite.exists?(student_id: student_id, organization_id: params[:organization_id])
  @errors = []
  if fav_found
    @errors << ["You've already favoured this organization, you can see it on your profile :)"]
    "******************"
    redirect '/organizations'  
  else
    Favourite.create(
      student_id: student_id,
      organization_id: params[:organization_id]
    )
    @organizations = Organization.all
    erb :'organizations/index'
  end
end

#students need a favourite button on the list of organizations page
#can only favourite once - button disappears if already favourited, replace with a star?
#favoured organizations will show up on their profile page(already set up on separate favourites page)


