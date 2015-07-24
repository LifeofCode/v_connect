require_relative '../app/models/student.rb'
Student.create(first_name: 'Sailor', last_name: 'Moon', email: 'moon@gmail.com', password_digest: 'moon')
Student.create(first_name: 'Sailor', last_name: 'Venus', email: 'venus@gmail.com', password_digest: 'venus')
Student.create(first_name: 'Sailor', last_name: 'Jupiter', email: 'jupiter@gmail.com', password_digest: 'jupiter')
Student.create(first_name: 'Sailor', last_name: 'Mercury', email: 'mercury@gmail.com', password_digest: 'mercury')
Student.create(first_name: 'Sailor', last_name: 'Mars', email: 'mars@gmail.com', password_digest: 'mars')

Organization.create(name: 'Red Cross', email: 'redcross@gmail.com', phone_number: '789-789-789')
Organization.create(name: 'Big Brother Big Sister', email: 'bigbrobigsis@gmail.com', phone_number: '656-656-789')
Organization.create(name: 'Bureau of Bad Behaviour', email: 'badbehaviour@gmail.com', phone_number: '147-417-789')
Organization.create(name: 'Negamoon', email: 'negamoon@gmail.com', phone_number: '635-123-789')
Organization.create(name: 'Dark Moon Circus', email: 'circus@gmail.com', phone_number: '456-965-789')

Favourite.create(organization_id: 1, student_id: 1)
Favourite.create(organization_id: 2, student_id: 2)
Favourite.create(organization_id: 3, student_id: 3)
Favourite.create(organization_id: 3, student_id: 1)
Favourite.create(organization_id: 1, student_id: 2)

Opportunity.create(organization_id: 1, title: 'Luna Agency', content: 'Currently looking for volunteers. Must be agent of love and justice!')
Opportunity.create(organization_id: 3, title: 'Artemis Agency', content: 'Currently looking for volunteers. Must be agent of love and courage!')
Opportunity.create(organization_id: 3, title: 'Tuxedo Men', content: 'Currently looking for volunteers. Must be agent of love and peace!')
Opportunity.create(organization_id: 2, title: 'Light Agency', content: 'Currently looking for volunteers. Must be agent of love and beauty!')
Opportunity.create(organization_id: 4, title: 'Sailor Squad', content: 'Currently looking for volunteers. Must be agent of love and intellect!')


