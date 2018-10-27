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
pry(main)> require 'soql_builder'

pry(main)> builder = SoqlBuilder.new(type: :select)
```

**Simple select query**
```ruby
# In the fields you can add parent table fields, exaple Contract__r,Name below
pry(main)> builder.fields(['Name', 'Contract__r.Name'])
                  .from('Account')
                  .where('id = 1')

pry(main)> builder.query
=> "select Name, Contract__r.Name from Account where id = 1"

```

**Select query with subquery**

```ruby
pry(main)> builder.fields(['Name', 'Contract__r.Name'])
                  .add_subquery(
                    table: 'Account.Quotes',
                    fields: ['Quotes.Name', 'Quotes.id']
                  )
                  .from('Account')
                  .where('id = 1')

pry(main)> builder.query
=> "select Name, Contract__r.Name , (select Quotes.Name, Quotes.id from Account.Quotes) from Account where id = 1"

```


