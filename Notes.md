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

### Hashes and Strings
Hashes are essentially arrays that aren’t limited to integer indices.
```ruby
>> user = {}                          # {} is an empty hash.
=> {}
>> user["first_name"] = "Michael"     # Key "first_name", value "Michael"
=> "Michael"
>> user["last_name"] = "Hartl"        # Key "last_name", value "Hartl"
=> "Hartl"
>> user["first_name"]                 # Element access is like arrays.
=> "Michael"
>> user                               # A literal representation of the hash
=> {"last_name"=>"Hartl", "first_name"=>"Michael"}
```
*Although hashes resemble arrays, one important difference is that hashes don’t generally guarantee keeping their elements in a particular order.*

```ruby
>> user = { "first_name" => "Michael", "last_name" => "Hartl" }
=> {"last_name"=>"Hartl", "first_name"=>"Michael"}
```

You can think of symbols as basically strings without all the extra baggage
`:name`

This is how we would define user's hash keys as symbols
```ruby
user = { :name => "Michael Hartl", :email => "michael@example.com" }
```

You can also add keys and values without a hashrocket using `key: value`
```ruby
>> h1 = { :name => "Michael Hartl", :email => "michael@example.com" }
=> {:name=>"Michael Hartl", :email=>"michael@example.com"}
>> h2 = { name: "Michael Hartl", email: "michael@example.com" }
=> {:name=>"Michael Hartl", :email=>"michael@example.com"}
>> h1 == h2
=> true
```

Nested Hashes
```ruby
>> params = {}        # Define a hash called 'params' (short for 'parameters').
=> {}
>> params[:user] = { name: "Michael Hartl", email: "mhartl@example.com" }
=> {:name=>"Michael Hartl", :email=>"mhartl@example.com"}
>> params
=> {:user=>{:name=>"Michael Hartl", :email=>"mhartl@example.com"}}
>>  params[:user][:email]
=> "mhartl@example.com"
```

### CSS Revisited
Parentheses on function calls are optional in Ruby, so these two are equivalent
```ruby
stylesheet_link_tag('application', media: 'all',
                                   'data-turbolinks-track' => true)
stylesheet_link_tag 'application', media: 'all',
                                   'data-turbolinks-track' => true
```

 When hashes are the last argument in a function call, the curly braces are optional, so these two are equivalent:
 ```ruby
 # Curly braces on final hash arguments are optional.
stylesheet_link_tag 'application', { media: 'all',
                                     'data-turbolinks-track' => true }
stylesheet_link_tag 'application', media: 'all',
                                   'data-turbolinks-track' => true
```
`data-turbolinks-track` uses the `=>` instead of `data-turbolinks-track:` because the hyphens are not valid for a symbol.

### Ruby classes
##### Constructors
```ruby
>> s = "foobar"       # A literal constructor for strings using double quotes
=> "foobar"
>> s.class
=> String
```

Instead of using a literal constructor, we can use the equivalent named constructor, which involves calling the new method on the class name:
```ruby
>> s = String.new("foobar")
=> "foobar"
>> s.class
=> String
>> s == "foobar"
=> true
```
```ruby
>> h = Hash.new
=> {}
>> h[:foo]            # Try to access the value for the nonexistent key :foo.
=> nil
>> h = Hash.new(0)    # Arrange for nonexistent keys to return 0 instead of nil.
=> {}
>> h[:foo]
=> 0
```

### Class Inheritance
Finding a class's superclase:
```ruby
>> s = String.new("foobar")
=> "foobar"
>> s.class                        # Find the class of s.
=> String
>> s.class.superclass             # Find the superclass of String.
=> Object
>> s.class.superclass.superclass  # Ruby 1.9 uses a new BasicObject base class
=> BasicObject
>> s.class.superclass.superclass.superclass
=> nil
```

#### Creating a class
```ruby
class word
  def palindrome?(string)
    string == string.reverse
  end
end
```

Since a word is a string, it’s more natural to have our Word class inherit from `String`
```ruby
>> class Word < String             # Word inherits from String.
>>   # Returns true if the string is its own reverse.
>>   def palindrome?
>>     self == self.reverse        # self is the string itself.
>>   end
>> end
=> nil
```
Having word inherit from string it allows word to have all the same methods as the string class.
Essentially this has all the same methods with addition to the palindrome method

#### Modifying built-in classes
```ruby
>> class String
>>   # Returns true if the string is its own reverse.
>>   def palindrome?
>>     self == self.reverse
>>   end
>> end
=> nil
>> "deified".palindrome?
=> true
```
Ruby allows classes to be opened and modified.

#### Example user
```ruby
>> require './example_user'     # This is how you load the example_user code.
=> true
>> example = User.new
=> #<User:0x224ceec @email=nil, @name=nil>
>> example.name                 # nil since attributes[:name] is nil
=> nil
>> example.name = "Example User"           # Assign a non-nil name
=> "Example User"
>> example.email = "user@example.com"      # and a non-nil email address
=> "user@example.com"
>> example.formatted_email
=> "Example User <user@example.com>"
```

# Chapter 4
### Adding Some Structure

```js
<!--[if lt IE 9]>
  <script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/r29/html5.min.js">
  </script>
<![endif]-->
```
This says if the browser is less than Internet Explorer 9 run the script

```
<%= link_to "sample app", '#', id: "logo" %>
```
Uses the rails `link_to` helper method used to create links which were created here.

```html
<h1>Sample App</h1>
<p>
  This is the home page for the
  <a href="http://www.railstutorial.org/">Ruby on Rails Tutorial</a>
  sample application.
</p>
```
1st argument: link Text
2nd argument: url (not filled in yet)
3rd argument: The third argument is an options hash, in this case adding the CSS id logo to the sample app link.

# Chapter 5
### Asset directories
app/assets: assets specific to the present Application
lib/assets: assets for libraries written by your team
vendor/assets: assets from third-party vendors

### Manifest Files
Once assets in their logical locations, use *manifest files* to tell Rails (via the Sprockets gem) how to combine them to form single files.
