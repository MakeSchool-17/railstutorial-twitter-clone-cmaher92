# Chapter 4

```html
<!DOCTYPE html>
<html>
  <head>
    <title><%= yield(:title) %> | Ruby on Rails Tutorial Sample App</title>
    <%= stylesheet_link_tag    'application', media: 'all',
                                              'data-turbolinks-track' => true %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
    <%= csrf_meta_tags %>
  </head>
  <body>
    <%= yield %>
  </body>
</html>
```

The following code used the `stylesheet_link_tag` Rails function (helper) to include application.css for all media types (including computer screens and printers).
```
<%= stylesheet_link_tag 'application', media: 'all',
                                       'data-turbolinks-track' => true %>
```

### Creating a custom helper

The following code relies on the definition of a page title.
```
<%= yield(:title) %> | Ruby on Rails Tutorial Sample App
```

The page title is provided by the `provide` helper in each view.
```
<% provide(:title, "Home") %>
```

If the title is removed the full title would appear as follows.
```
 | Ruby on Rails Tutorial Sample App
 ```

 To remedy this, it's best practice to provide a *base title* with an optional page title to be more specific.

 To solve the problem of the missing page title creating a *custom helper* called full-title that will return a *base title*.
 More specifically, The full_title helper returns a base title, “Ruby on Rails Tutorial Sample App”, if no page title is defined, and adds a vertical bar preceded by the page title if one is defined.

 ```Ruby
 module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
```

The following code would be placed in the html `<title>` tag.
*app/views/layouts/application.html.erb*
```html
<title><%= full_title(yield(:title)) %></title>
```

After this is added it's important to remember to remove the `provide` helper from the specific views and to change the tests.

## Strings and Methods
### Rails Console
```
$ rails console
```
`Ctrl + C` if you get stuck `Ctrl + D` exit console all together.

### String Interpolation
```Ruby
first_name = "Connor"
"#{first_name} Maher" # returns Connor Maher
```

### String Methods
`.empty?` -> The question mark means that it returns true or false
`.include?("foo")` -> Does the string include `"foo"`
`&&` And operator for combining booleans
`||` Or operator
`!` Not operator
`to_s` Can convert nearly any object to a string
`.nil?` Checks to see if object is of `nil` value

```ruby
puts "x is not empty" if !x.empty?
```
`if` `x` is not(`!`) empty(`empty?`) then execute `puts`

Ruby has a similar keyword called `unless` used in the following example.
```ruby
>> string = "foobar"
>> puts "The string '#{string}' is nonempty." unless string.empty?
The string 'foobar' is nonempty.
=> nil
```

Use `!!` to coerce a true boolean value.
`!!nil` will return `false`

### Method definitions
```ruby
def string_message(str = '')
  if str.empty?
    "It's an empty string!"
    else
    "The string is nonempty."
  end
end
```

Note The map method can be used to create a new array based on the original array, but with the values modified by the supplied block:

Note that Ruby functions have an implicit return, meaning they return the last statement evaluated
Ruby also has an explicit return option; the following function is equivalent to the one above
```ruby
def string_message(str="")
  return "It's an empty string" if str.empty?
  return "The string is nonempty"
end
```

The final element is `module ApplicationHelper:` `modules` give us a way to package together related methods, which can then be mixed in to Ruby classes using `include.`

### Other Data Structures
there’s a natural way to get from strings to arrays using the `split` method, the following example defaults to splitting on whitespace.
```ruby
>>  "foo bar     baz".split     # Split a string into a three-element array.
=> ["foo", "bar", "baz"]
```

You can split on anything, like in the following example the `String` is split using `'x'`
```ruby
>> "fooxbarxbazx".split('x')
=> ["foo", "bar", "baz"]
```

Array methods
Note: Look into `sort`, what's the algorithm behind this?
```ruby
>> a
=> [42, 8, 17]
>> a.empty?
=> false
>> a.include?(42)
=> true
>> a.sort
=> [8, 17, 42]
>> a.reverse
=> [17, 8, 42]
>> a.shuffle
=> [17, 42, 8]
>> a
=> [42, 8, 17]
```

None of the above methods actually mutate the arrays, to mutate the arrays use the `!` method.
```ruby
>> a
=> [42, 8, 17]
>> a.sort!
=> [8, 17, 42]
>> a
=> [8, 17, 42]
```

`.push()` method to add to arrays also can be notated as `<<`
```ruby
>> a = [1, 2, 3, 4]
>> a << "five" << "six"
=> [1, 2, 3, 4, "five", "six"]
```

`.join` method converts an array to a string

`range` method
```ruby
>> (0..9).to_a            # Use parentheses to call to_a on the range.
=> [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
```

Make a string array
```ruby
a = %w[foo, bar, baz, quux]
```

### Blocks
```ruby
>> (1..5).each { |i| puts 2 * i }
2
4
6
8
10
=> 1..5
```
In the above code
- the `.each` method is called on the range `(1..5)`
- each element in the range has `{ |i| puts 2 * i }` applied to it
- Within that block `|i|` sets the variable
- puts multiplies `i` by 2

Curly braces are used for short one-line blocks, otherwise `do` and `end` are used
```ruby
>> (1..5).each do |i|
>>   puts 2 * i
>> end
2
4
6
8
10
=> 1..5
```
