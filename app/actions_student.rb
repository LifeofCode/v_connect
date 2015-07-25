#display all students that are registered
get '/students' do 
  @students = Student.all
  erb :'students/index'
end

# organization can search for student by first and last names
get '/students/search' do
  redirect '/students' if params[:keyword].empty?
  @students = Student.where("lower(first_name) LIKE ? OR lower(last_name) LIKE ?", "%#{params[:keyword].downcase}%", "%#{params[:keyword].downcase}%")
  if @students.empty?
    @errors << "Cannot find student with #{params[:keyword]}"
    @students = Student.all
  end
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
  @organizations = current_student.organizations
  erb :'/students/show'
end

# a student can edit their profile
get '/students/edit' do
  auth_student!
  erb :'/students/edit'
end

#a student can see their favourite organizations
# TODO: is this neccessary? Since the info is already on the profile page
# At the very least, split into a partial instead of using organiaztions/index.erb
get '/students/organizations' do
  auth_student!
  check_favourites
  @organizations = current_student.organizations
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
    # @student = nil
    erb :'students/login'
  end
end

# update student info
put '/students' do
  auth_student!
  if @student.update(params[:student])
    session[:name] = @student.first_name
    redirect '/students/profile'
  else
    @errors = @student.errors.full_messages
    # @student = nil
    erb :'students/edit'
  end
end

post '/favourite' do 
  @new_fav = Favourite.new(
      student_id: session[:id],
      organization_id: params[:organization_id]
    )
  if @new_fav.save
    redirect '/organizations'
  else
    @errors = @new_fav.errors.full_messages
  # TODO: dry this out
    check_favourites
    @organizations = Organization.all
    erb :'organizations/index'
  end
end

delete '/favourite' do
  auth_student!
  @favourite = Favourite.find_by(
    student_id: session[:id], 
    organization_id: params[:organization_id]
  )
  @favourite.destroy if @favourite
  redirect "#{params[:redirect]}"
end