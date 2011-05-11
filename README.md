INCYDE.ME! The incyde source for social monetization
====================================================
**Site**: 	[http://www.incyde.me] (http://www.incyde.me)
**Author**:	Thomas W. Devol
**Class**:	CIS 591
**Instructor**:	John Satzinger
**License**:	MIT License
**Release**:	May 1st, 2011

Synopsis
--------
Incyde.me provides end-users the ability to record their personal thoughts which they would never want to share with anyone in an online location. Somewhat of a "microjournal". The application provides advertisers a method to advertise to these users using contextual advertising based on the content of the posts. The site includes a robust permissions management system to control access to features added to the site.

Features
--------
**1. End users can sign-up and post content to the site. A list of their posts is displayed.
**2. Advertisers may create searches which show posts matching the contents of the search. They may create an Advertisement from their search which will then display to end-users any time a post is on the screen matching the associated search.
**3. Advertisers may view a report of all the activity on each advertisement, the report will show impressions and clicks by day and is filterable by date.
**4. Advertisers may export search results as CSV,PDF and XML.
**5. Advertisers may manage their billing online and view their payment history.
**5. Administrators may create new groups and permission keys beyond advertisers as the needs arise.
**6. A user activity report is available showing the number of posts, signups and frequency analysis data of all the content posted on the site between the dates of the report.
Browsing The Source
-------------------

The application's models, views and controllers are in the "app" directory above. Additional objects include 
**Migrations**: These are essentially files which instantiate the database. There are initial migrations and transformation migrations. Transformation migrations indicate a change to the database. I've created all the migration in the applications so to take advantage of revision control features in the database. These files are located in "db/migrate" (The migrate folder under the db folder)
**Fixtures**: These are definitions of initial testing data for the application. These are found in "test/fixtures"
**Unit Tests**: These classes execute code from the application using the test data from the fixtures and ensures that the result matches expectations. These are located in "test/unit"
**Functional Tests**: These classes execute code from the controllers in the application using the test data from the fixtures and ensures that the result matches expectations. These are located in "test/functional"
**Rake Tasks**: These are procedures which perform application maintenance taks. These are mainly for test data generation. They are located in "lib/tasks"

Why I should get an A
---------------------
* I used best-practices for design and implementation using behavior/test driven development.
* Best practices for modern usability were followed including the "golden triangle" principle. Visual cues such as icons and aesthetic consistency. 
* The application creates visually informative reports gathering information from disparate models and areas of the application. 
* Whereas other applications exhaust CRUD, my application applies full CRUD as its necessary and goes beyond CRUD into business intelligence and analytics.  
* Because I spent way more time than necessary on certain parts of the project - even though they were not requirements. (Hand picking icons, Creating realisitic test data, 3rd party API integration, this documentation)
