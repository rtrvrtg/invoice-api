# Invoice API

by Geoffrey Roberts  
[g.roberts@blackicemedia.com](mailto:g.roberts@blackicemedia.com)

Does a few simple tasks:

* Manages user logins and API keys
* Allows you to create Apps that can own Invoices
  * Apps have a name 
  * They also have a stub which will be on the ID of every invoice that belongs to it
* This doesn't manage payments or money or anything

## Installation

Once you've git cloned this to your local system:

* bundle install
* alias be="bundle exec"
* be rake invoice:install
  * Edit the resulting config/environments.rb file
* be rake db:create
* ./run.sh

All requests to this system must contain a query string variable called "key" that contains an API key belonging to a user authorisation.

## Rake tasks

* rake "invoice:makeuser[admin,password123]"
  Creates a user with username admin and password password123.
* rake "invoice:apikey[admin]"
  Gets the API key for the user you created
* rake "invoice:makeapp[Stationery,STAT,2]"
  Creates an App called Stationery with stub STAT, starts numbering at 2.
* rake "invoice:makeinvoice[More pencils,STAT]"
  Creates an Invoice with purpose "More pencils", belonging to the App with stub STAT.

## Pathways

* GET /apps/index.json
  Gets a list of all available Apps.
* GET /invoices/index.json
  Gets a list of all available Invoices.
* GET /invoices/(STUB)-(year).json
  Gets a list of all available Invoices for a given App (defined by STUB) in a given year.

More to come!

## To do

* Generate PDF or Word Doc templates
* Some HTML output?

## Licensing

Copyright © Geoffrey Roberts 2013. All rights reserved.

This isn't ready for prime time yet, but once I'm happy with it I'll probably MIT license it. Sit tight.
