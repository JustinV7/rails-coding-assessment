# Apple Rails Coding Assessment
### By: Justin Van Dyke

##### Prerequisites

The setup steps expect the following tools and accounts to be available on the system.

- Github
- Ruby [3.0.0](https://github.com/organization/project-name/blob/master/.ruby-version#L1)
- Rails [6.1.7.10](https://github.com/organization/project-name/blob/master/Gemfile#L12)
- Visual Crossing Weather API [Sign-up](https://www.visualcrossing.com/sign-up)

##### 1. Check out the repository and bundle the project.

```bash
git clone git@github.com:JustinV7/rails-coding-assessment.git
cd rails-coding-assessment
bundle
```

##### 2. Create and setup the MySQL database.

Run the following command to create and setup the database.

```ruby
bundle exec rails db:create
bundle exec rails db:setup
```

#### 3. create environment variable with API Key.

An environment variable is used to access weather forecast data in the API of this project.

```bash
export WEATHER_API_KEY = "SAMPLE_API_KEY"
```

##### 4. Start the Rails server.

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

And now you can visit the API documentation with the URL http://localhost:3000/apipie
