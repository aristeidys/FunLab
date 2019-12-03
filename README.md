# FunLab_Backend


Deployment

1. Change to develop Branch
2. cd Backend
2. rails db:migrate (to create the database tables)
3. rails server

Rails Command Line

* rails c
* Activity.create!(title: "Im the activity", lab_session_id: LabSession.first.id)
* LabSession.create!(title: "Hello", finished:false)
* LabSession.first


Database Commands

* rails db:migrate                    (After a model or association is created)

* bundle exec rake db:rollback        (Database goes back one migration)

* bundle exec rake db:drop db:create db:migrate. (Creates the DB from scratch)

* rails destroy model LabSession 

* rails generate model LabSession title:string finished: boolean

* rails g migration add_activity_reference_to_lab_sessions activity:references (session has many activities)

* rails generate migration add_email_to_users email:string (+ rails db:migrate)

OR
* rails generate migration CreateStudentEnrollments (when you want to fill the migration yourself)

* fresh database
  rake db:drop      
  rake db:create         
  rake db:schema:load  

Other Commands

* rails new Backend --api
* rails server
* rails routes
* rails g controller Activities
