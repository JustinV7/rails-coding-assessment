# Apple Rails Coding Assessment

##### Prerequisites

The setups steps expect following tools installed on the system.

- Github
- Ruby [3.0.0](https://github.com/organization/project-name/blob/master/.ruby-version#L1)
- Rails [6.1.7.10](https://github.com/organization/project-name/blob/master/Gemfile#L12)

##### 1. Check out the repository

```bash
git clone git@github.com:JustinV7/rails-coding-assessment.git
```

##### 3. Create and setup the MySQL database

Run the following commands to create and setup the database.

```ruby
bundle exec rake db:create
bundle exec rake db:setup
```

##### 4. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

And now you can visit the site documentation with the URL http://localhost:3000/apipie
