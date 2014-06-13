# Bogusdb

`Bogusdb` is a `fake` ORM database object--Nothing more, nothing less.
There are great tools out there that do the similar things--and do it much better.  If you need more
features you are probably better off using one of those.
The problem is most require heavy dependencies with them.  Also, most tools assume you are using active record and or in a rails environment.  

`Bogusdb` can be used in tests where you do not want to actually create any data, 
 but need to `unit` test your logic against a object that quacks like a ORM object.
 

* I use this when testing daemons that have DB dependencies

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
* Note the id is optional

```ruby
@user = Bogusdb::Record.new(id: 10, first_name: 'foo', last_name: 'bar')
@user.id         #=> 10
@user.first_name #=> 'foo'
@user.last_name  #=> 'bar'
@user.attributes #=> {:last_name=>"bar", :id=>10, :first_name=>"foo"}
@user.inspect    #=> "#<Bogusdb::Record: last_name: bar, id: 10, first_name: foo"
```

## Create multiple records at the same time
```ruby
@user = Bogusdb::Record.create([ { first_name: 'foo', last_name: 'bar' },
                                 { first_name: 'Fizz', last_name: 'Buzz' } ])
@user   #=> [#<Bogusdb::Record: id: 10, first_name: 'foo', last_name: 'bar', 
             #<Bogusdb::Record: id: 23, first_name: 'Fizz', last_name: 'Buzz']
```

## Join table
```ruby
@user = Bogusdb::Record.new(first_name: 'foo', last_name: 'bar')
@user.join_table(:profile, {id: 1, avatar: 'image.jpg', gender: 'M'})
@user.profile            #=>  #<Bogusdb::Record: avatar: image.jpg, id: 1, gender: m
@user.profile.attributes #=> {id: 1, avatar: 'image.jpg', gender: 'M'}
```

## Join a table with more familiar syntax
```ruby
@user = Bogusdb::Record.new(first_name: 'foo', last_name: 'bar')
@user.has_one(:profile, {id: 1, avatar: 'image.jpg', gender: 'M'})
@user.profile            #=>  #<Bogusdb::Record: avatar: image.jpg, id: 1, gender: m
@user.profile.attributes #=> {id: 1, avatar: 'image.jpg', gender: 'M'}
```

```ruby
@user = Bogusdb::Record.new(id: 10, first_name: 'foo', last_name: 'bar')
@user.has_many(:addresses, [{street: '123 main', city: 'Denver'},
                            {street: '456 boulder dr', city: 'Boulder'}])

@user.addresses #=>  [#<Bogusdb::Record: street: '123 main', city: 'Denver', 
                      #<Bogusdb::Record:  street: '456 boulder dr', city: 'Boulder']
```




## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
