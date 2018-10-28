# SOQL-BUILDER (BETA)

A ruby SOQL query builder, it doesn't include all the available SOQL queries. Contributions are welcome.

## How to use

```ruby
# ruby
gem install 'soql_builder'

# rails
gem 'soql_builder'
```

```ruby
require 'soql_builder'

builder = SoqlBuilder.new(type: :select)
```

**Simple select query**
```ruby
# In the fields method you can add parent table fields, an exaple of Contract__r.Name below
builder.fields(['Name', 'Contract__r.Name'])
       .from('Account')
       .where('id = 1')

builder.query
=> "select Name, Contract__r.Name from Account where id = 1"

# Add a limit
builder.fields(['Name', 'Contract__r.Name'])
       .from('Account')
       .where('id = 1')
       .limit(1)

builder.query
=> "select Name, Contract__r.Name from Account where id = 1 limit 1"

```

**Select query with subquery**

```ruby
builder.fields(['Name', 'Contract__r.Name'])
       .add_subquery(
         table: 'Account.Quotes',
         fields: ['Quotes.Name', 'Quotes.id']
       )
       .from('Account')
       .where('id = 1')

builder.query
=> "select Name, Contract__r.Name, (select Quotes.Name, Quotes.id from Account.Quotes) from Account where id = 1"

```

**Queries can be added one at a time, instead of chaining**

```ruby
builder.fields(['Name', 'Contract__r.Name'])

builder.add_subquery(
         table: 'Account.Quotes',
         fields: ['Quotes.Name', 'Quotes.id']
       )

builder.from('Account')

builder.where('id = 1')

builder.query
=> "select Name, Contract__r.Name, (select Quotes.Name, Quotes.id from Account.Quotes) from Account where id = 1"
```


