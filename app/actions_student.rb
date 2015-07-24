#display all students that are registered
get '/students' do 
  @students = Student.all
  erb :'students/index'
end

# student sign up page
get '/students/register' do
  if current_student?
    redirect '/students/profile'
  else
    @student = nil
    erb :'students/new'
  end
end

# student login page
get '/students/session' do
  if current_student?
    redirect '/students/profile'
  elsif current_org?
    redirect '/organizations/profile'
  else
    @student = nil
    erb :'students/login'
  end
end

get '/students/profile' do
  if current_student?
    erb :'/students/show'
  elsif current_org?
    redirect '/organizations/profile'
  else 
    redirect '/'
  end
end

get '/students/edit' do
  if current_student?
    erb :'/students/edit'
  else
    redirect '/'
  end
end

#a student can see their favourite organizations
get '/students/:id/organizations' do
  @student = Student.find(params[:id])
  @organizations = @student.organizations
  erb :'organizations/index'
end

# create new student
post '/students' do
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
  if @student && @student.authenticate(params[:password])
    session[:id] = @student.id
    redirect '/students/profile'
  else
    @student = nil
    @errors << "Invalid login"
    erb :'students/login'
  end
end

put '/students' do
  # TODO: only ask for password if there has been an update
  @student = current_student
  if @student.authenticate(params[:password])
    if @student.update(params[:student])
      redirect '/students/profile'
    else
      @errors = @student.errors.full_messages
      erb :'students/edit'
    end
  else
    @errors << 'please enter your password' 
    erb :'students/edit'
  end
end