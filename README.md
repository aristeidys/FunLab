# FunLab_Backend


Deployment

Backend
1. Change to develop Branch
2. cd Backend (Command)
2. rails db:migrate (Command)
3. rails server (Command)
4. Download a Postgres Database (https://www.postgresql.org/download/)
5. Install and run the Database.
6. Save user, password, host and database name selected.
5. Configure .env root file in the project to have correct user, password, host and database name

FrontEnd
1. Download Visual Studio Code
2. cd Apps (Command)
3. at the bottom click on "No Device" and select "Start Flutter Emulator" from the options given
4. flutter run -d all  -t lib/common/helpers/main.dart (Command)


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
