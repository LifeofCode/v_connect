#display all students that are registered
get '/students' do 
  @students = Student.all
  erb :'students/index'
end

# organization can search for student by first and last names
get '/students/search' do
  @students = Student.where("lower(first_name) LIKE ? OR lower(last_name) LIKE ?", "%#{params[:keyword].downcase}%", "%#{params[:keyword].downcase}%")
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
  @student = current_student
  @organizations = current_student.organizations
  @student_favs = @organizations.map {|organization| organization.id}
  erb :'/students/show'
end

# a student can edit their profile
get '/students/edit' do
  auth_student!
  erb :'/students/edit'
end

#a student can see their favourite organizations
get '/students/organizations' do
  auth_student!
  @organizations = current_student.organizations
  @student_favs = []
  @student_favs = @organizations.map {|organization| organization.id}
  erb :'organizations/index'
end

get '/students/:id' do 
  @student = Student.find(params[:id])
  erb :'students/show'
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
  @fav_found = Favourite.exists?(student_id: session[:id], organization_id: params[:organization_id])
  @student_favs = []
  @organizations = Organization.all
  @student_favs = current_student.organizations.map {|organization| organization.id} if current_student?

  if @fav_found
    @errors << "You've already favoured this organization, you can see it on your profile :)"
    erb :'/organizations/index'  
  else
    Favourite.create(
      student_id: session[:id],
      organization_id: params[:organization_id]
    )
    redirect '/organizations'
  end
end

delete '/favourite' do
  auth_student!
  @favourite = Favourite.find_by(
    student_id: session[:id], 
    organization_id: params[:organization_id]
  )
  @favourite.destroy
  redirect '/organizations'
  # TODO: redirect to student profile
end