# Bogusdb

A simple `FAKE` ORM database object.
I use this when testing daemons that have DB dependencies, 
but wish not to connect to the database at all.

## Installation

Add this line to your application's Gemfile:

    gem 'bogusdb'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bogusdb

## Usage

So, lets say you need a table named `:user` with these column names and values
```
first_name: 'foo'
last_name: 'bar'
```

## Create a row 
```ruby
@user = Bogusdb::Record.new(id: 10, first_name: 'foo', last_name: 'bar')
@user.id         #=> 10
@user.first_name #=> 'foo'
@user.last_name  #=> 'bar'
@user.attributes #=> {:last_name=>"bar", :id=>10, :first_name=>"foo"}
@user.inspect    #=> "#<Bogusdb::Record: last_name: bar, id: 10, first_name: foo"
```
## Join table
```ruby
@user = Bogusdb::Record.new(id: 10, first_name: 'foo', last_name: 'bar')
@user.join_table(:profile, {id: 1, avatar: 'image.jpg', gender: 'M'})
@user.profile            #=>  #<Bogusdb::Record: avatar: image.jpg, id: 1, gender: m
@user.profile.attributes #=> {id: 1, avatar: 'image.jpg', gender: 'M'}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
