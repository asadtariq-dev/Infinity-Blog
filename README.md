# Infinity Blog
Blog Application based on ROR.

ABSTRACT:
Infinity Blog is a web application for authors to publish there blog posts. Following are the features:

* Users can see the published posts that are approved by the moderator.
* Users can like/ comment on post.
* Users cann report any post.
* User can post suggestion under any post.
* Moderator can approve a post submitted by users.
* Moderator can delete/ unpublish reported posts.
* Admin can manage all the posts, users, comments, likes, reports and all other objects from user.

ROLES:
* Author
* Moderator
* Admin

FUNCTIONALITY:
* User Authentication using devise.
* User Authorization using pundit.
* Admin dashboard using RailsAdmin
* Cloudinary storage service for attachments.
* Styling using bootstrap and sassc.

PROGRAMMING ENVIRONMENT:
* Frontend: HTML, CSS/SCSS, Bootstrap
* Backend: Rails
* Database: postgresql

COMPATIBLE VERSIONS:
* Ruby : 2.7
* Rails : 7.0.3
* Postgres : 14.5

INSTRUCTIONS:
1. Download the github repository Infinty-Blog
2. Extract the file and copy Infinity-Blog folder
3. Now use any development editor and open the folder ( Perfer VS Code)
4. Setup a database. (rails db:setup)
5. Run bundle install so that all the dependencies are installed.
6. Run rails db:migrate so that all migrations are up.
7. Run rails db:seed so that db is populated.
7. Run rails server to start your local server.
8. Now go to 'localhost:3000' you interface will be their.
9. Use the Following Credential to log in.
    * For Admin
      Email: admin@test.com
      Password: 12345678

    * For Moderator
      Email: moderator@test.com
      Password: 12345678

10. Now you play with the application.
