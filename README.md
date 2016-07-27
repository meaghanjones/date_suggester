# :two_women_holding_hands::heart:GR8Date:heart::two_men_holding_hands:

##### This application is  designed to allow a user to store, update, delete and view date ideas. The date ideas can be saved with the following information: name, address, description and rating. If the user wishes they can also tag the dates with categories and then view all the dates with the same categories.

## Technologies Used

Application: Ruby, Sinatra, Active Record<br>
Testing: Rspec, Capybara<br>
Database: Postgres

Installation
------------
Begin the installation by cloning the repository from github.
```
$ git clone https://github.com/meaghanjones/date_suggester.git
```
Install bundler
```
$ gem install bundler
```

Install required gems in the local repository:
```
$ bundle install
```
Run Postgres
```
$postgres
```
Create databases:
```
rake db:create
rake db:schema:load
```

Start the webserver:
```
$ ruby app.rb
```

Navigate to `localhost:4567` in browser.

License
-------
This software is licensed under the MIT license.
Copyright (c) 2016 **Alex Hagge, Erin Goncer, Halle Williams, Jake Richmond, Lauren Posey, Meaghan Jones, Stephanie Gurung**
