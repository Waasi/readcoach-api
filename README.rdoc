# ReadCoach API
### About ReadCoach

This is an API created to serve data to ReadCoach Front End EmberJS APP. ReadCoach
is a web app designed to help people learning to read or people that want to improve
their reading skills. The user can practice all he/she desires and then put their skills
to the test and see their improvement over time.

### Configuration

All you need to configure ReadCoach API is do:

```ruby
bundle install
```
and have the secrets.yml available

### Database creation

To create the database just do:

```ruby
rake db:setup
```

### Tests Suite

To run all test do:

```ruby
rspec
```

### Deployment

- ```git clone git@github.com:Waasi/readcoach-api.git```
- ```bundle install```
- ```heroku login``` => with respective credentials
- ```heroku create```
- ```git push heroku master```
- ```heroku run rake db:migrate```
- ```heroku ps:scale web=1```

## Access to the ReadCoach API

## Endpoints

##### Sign In
- Method: ```POST```

- Endpoint: ```users/sign_in```

- Parameters: ```{ email: email_here, password: password_here }```

- Response: ```{ user: { name: name_here, email: email_here, password: password_here, password_confirmation: password_confirmation_here, age: age_here, language: 'es', token: 'atokenhere' } }```

##### Sign Up
- Method: ```POST```

- Endpoint: ```users```

- Parameters: ```{ user: { name: name_here, email: email_here, password: password_here, password_confirmation: password_confirmation_here, age: age_here, language: 'es' } }```

- Response: ```{ user: { name: name_here, email: email_here, password: password_here, password_confirmation: password_confirmation_here, age: age_here, language: 'es', token: 'atokenhere' } }```

##### Training
- Method: ```GET```

- Endpoint: ```/training```

- Parameters: ```{ email: email_here, token: token_here }```

- Response: ```{ training: [{ word: word_here, image: image_url_here }, ....] }```

##### Test
- Method: ```GET```

- Endpoint: ```/test```

- Parameters: ```{ email: email_here, token: token_here }```

- Response: ```{ test: [ word_here, word_here, ....] }```

##### Advanced Training
- Method: ```GET```

- Endpoint: ```/training```

- Parameters: ```{ email: email_here, token: token_here }```

- Response: ```{ training: [ phrase_here, phrase_here, ....] }```

##### Advanced Test
- Method: ```GET```

- Endpoint: ```/test```

- Parameters: ```{ email: email_here, token: token_here }```

- Response: ```{ test: [ phrase_here, phrase_here, ....] }```

##### Test Results
- Method: ```POST```

- Endpoint: ```/results```

- Parameters: ```{ email: email_here, token: token_here, words_read: word_count_here, phrase_count: phrase_count_here }```

- Response: ```{ user: { name: name_here, email: email_here, password: password_here, password_confirmation: password_confirmation_here, age: age_here, language: 'es', evaluations: [ { id: id_here, user_id: user_id_here, words_read: words_read_here, phrase_read: phrase_read_here }, ... ] } }```

##### Profile
- Method: ```GET```

- Endpoint: ```/profile```

- Parameters: ```{ email: email_here, token: token_here }```

- Response: ```{ user: { name: name_here, email: email_here, password: password_here, password_confirmation: password_confirmation_here, age: age_here, language: 'es', evaluations: [ { id: id_here, user_id: user_id_here, words_read: words_read_here, phrase_read: phrase_read_here }, ... ] } }```


### Contributing

1. Fork it ( https://github.com/[my-github-username]/yahoo_finanza/fork )
2. Create your feature branch (`git checkout -b feature/my_new_feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

### Special Thanks To:

1. Jonah Ruiz (jonahoffline)
2. Pedro Melendez (lazychino)
