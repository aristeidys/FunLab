# FunLab Instalation

Backend
1. Change to develop Branch
2. (Command) cd Backend
2. (Command) rails db:migrate
3. (Command) rails server
4. Download a Postgres Database (https://www.postgresql.org/download/)
5. Install and run the Database.
6. Save user, password, host and database name selected.
5. Configure .env root file in the project to have correct user, password, host and database name

FrontEnd
1. Download Visual Studio Code
2. (Command) cd Apps 
3. at the bottom click on "No Device" and select "Start Flutter Emulator" from the options given
4. (Command) flutter run -d all  -t lib/common/helpers/main.dart
