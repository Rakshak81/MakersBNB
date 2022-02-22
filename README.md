<!-- A high level description of the project specification.
A user stories section (leave it blank for now). -->

## Makersbnb specification:

We would like a web application that allows users to list spaces they have available, and to hire spaces for the night.

<!-- We would like a web application that allows users to list spaces they have available, and to hire spaces for the night.

Headline specifications

Any signed-up user can list a new space.
Users can list multiple spaces.
Users should be able to name their space, provide a short description of the space, and a price per night.
Users should be able to offer a range of dates where their space is available.
Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.
Nights for which a space has already been booked should not be available for users to book that space.
Until a user has confirmed a booking request, that space can still be booked for that night. -->


## User Stories:
````

As a user
To gain access to the website's letting/renting features
I would like to sign up for the website

As a host_user
To show what spaces I have for let
I would like to add my space to a list of space(s)

As a host_user
To show what spaces I have for let
I would like to display multiple space(s) on the website

As a host_user
To keep track of each space
I would like to name the space

As a host_user
To know what my space contains
I would like a description of the space

As a host_user
To be able to let out my space
I would like to set a price per night on each space

As a host_user
To be able to let out my space
I would like to show the dates that the space is available

As a tenant_user 
To be able to hire a space
I would be able to request to hire the space

As a host_user
When the tenant_user requests the use of the space
I would like to approve the request

As a host_user
So that I can remove the dates from the availability
I would like to confirm the tenant_user request

As a host_user
So that I can choose the best tenant_user
I would like this space to be availabe until the request is confirmed

As a tenant_user
So that I don't book a space that is not available
I would like to only see the available dates for that space

````


Instructions for 'spaces' database creation within psql.:

1. Connect to psql
2. Create the database using the psql command CREATE DATABASE spaces;
3. Connect to the database using the pqsl command \c spaces;
4. Run the query we have saved in the file 01_CREATE_USER_TABLE.SQL
5. Run the query we have saved in the file 02_add_title_to_bookmarks.sql


Instructions for 'spaces' test database creation within psql.:

1. Connect to psql
2. Create the database using the psql command CREATE DATABASE bookmark_manager_test;
3. Connect to the database using the pqsl command \c bookmark_manager_test;
4. Run the query we have saved in the file 01_create_bookmarks_table.sql
5. Run the query we have saved in the file 02_add_title_to_bookmarks.sql


````


MVC Model of Makerbnb website code:

![](Makersbnb_model.png)