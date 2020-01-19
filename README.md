# FunLab Instalation

Backend
1. Open a terminal and go inside the Backend folder
2. (Run Command) rails db:migrate
3. (Run Command) rails server
4. Download a Postgres Database (https://www.postgresql.org/download/)
5. Install and run the Database.
6. Note down the user, password, host and database name selected.
5. Configure .env root file that is inside the Backend folder to have correct user, password, host and database name

FrontEnd
1. Download Visual Studio Code (https://code.visualstudio.com/download)
2. Open the App folder inside Visual Code
3. at the bottom click on "No Device" and select "Start Flutter Emulator" from the options given
4. (Run Command inside the App folder) flutter run -d all  -t lib/common/helpers/main.dart

Tests
1. Download PostMan (https://www.getpostman.com/downloads/)
2. Click on the menu File -> Import to import the PostManCollection.json collection of tests
3. Run the Rails server and the Database.
4. Run the Collection from Postman 
