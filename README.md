# Ruby on Rails Tutorial: sample application

This is the sample application for the 
[*Ruby on Rails Tutorial: 
Learn Web Development with Rails*](http://www.railstutorial.org/)
by [Michael Hartl](http://www.michaelhartl.com/).
<br><br>
Please note that this is a modified version of the Sample App.  This version 
omits users.  The features provided in this app include testing (through 
Minitest), Guard, static pages, and Twitter bootstrap styling.
<br><br>
The Bash scripts in the root directory that allow you to perform routine 
tasks in only one step.  To execute the Bash (*.sh) scripts, enter the 
command "sh (name of script)". The Bash scripts provided are:

1.  test.sh: This command sets up and tests this Rails app.  When you first
clone this repository to a machine with a fresh Ruby on Rails installation, 
all tests should proceed as expected.  If all goes well, your app will 
pass all tests.  Please note that this script does NOT run code checking 
programs.
2.  test_code.sh: This command runs each of the installed code checking 
programs - brakeman, rubocop, sandi_meter, rails_best_practices, bundle-audit,
and metric_fu.
3.  server.sh: This script runs your local Rails server. Note that it 
specifies port 0.0.0.0 so that you can view your Rails app in your web browser 
when you do your Rails development in Vagrant.
4.  seed.sh: This script populates the database with simulated data.
5.  sandbox.sh: This script gives you the Rails console sandbox environment.
6.  heroku_upload.sh: This script uploads your Rails source code to Heroku 
AND runs the "rake db:migrate" command in the Heroku environment.
7.  kill_spring.sh: The Spring tool is useful but may occasionally slow 
down your Rails app. If you believe that this is happening, or if you're 
getting Spring-related errors, run this script to kill the Spring tool.
8.  list_files.sh: This script prints outlines of the path structure of 
the MVC and testing architectures in your Rails app into the file 
notes/1-list_files.txt. While this script has no impact on how your Rails 
app runs, it aids the process of outlining the MVC structure and the testing 
procedure in your app.
