#display all students that are registered
get '/students' do 
  @students = Student.all
  erb :'students/index'
end

# student sign up page
get '/students/register' do
  # redirect to profile page if user is already logged in
  logged_in!
  # create a blank student so entered data can be saved when registration fails
  @student = Student.new
  erb :'students/new'
end

# student login page
get '/students/session' do
  logged_in!
  erb :'students/login'
end

get '/students/profile' do
  auth_student!
  erb :'/students/show'
end

# a student can edit their profile
get '/students/edit' do
  auth_student!
  erb :'/students/edit'
end

#a student can see their favourite organizations
get '/students/:id/organizations' do
  auth_student!
  @organizations = @student.organizations
  erb :'organizations/index'
end

# create new student
post '/students' do
  @student = Student.new(params[:student])
  @student.password = params[:password]
  @student.password_confirmation = params[:password2]
  if @student.save
    login_user(@student.id, 'student')
  else
    @errors = @student.errors.full_messages 
    erb :'students/new'
  end
end

# login student
post '/students/session' do
  @student = Student.find_by(email: params[:email])
  if @student && @student.authenticate(params[:password])
    login_user(@student.id, 'student')
  else
    @errors << "Invalid login"
    erb :'students/login'
  end
end

put '/students' do
  auth_student!
  if @student.update(params[:student])
     redirect '/students/profile'
  else
    @errors = @student.errors.full_messages
    erb :'students/edit'
  end
end