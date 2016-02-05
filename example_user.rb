class User
  attr_accessor :name, :email # creates attribute accessors corresponding to a user’s name and email address.*
  # this creates “getter” and “setter” methods that allow us to retrieve (get) and assign (set) @name and @email instance variables
  # Instance variables always begin with an @ sign, and are nil when undefined.

  def initialize(attributes = {})  # initialize an empty hash named attributes
    @name  = attributes[:name]
    @email = attributes[:email]
  end

# Finally, our class defines a method called formatted_email that uses the values
# of the assigned @name and @email variables to build up a nicely formatted version
# of the user’s email address using string interpolation
  def formatted_email
    "#{@name} <#{@email}>"
  end
end
