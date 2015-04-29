# Rails Routing - Nested Attributes

## How do we handle multiple models in one form?!

Let's suppose that we want to create a Parent and a Child at the same time.  We can accomplish this using **Active Record Nested Attributes**  Nested attributes allow you to save attributes on associated records through the parent.

Read more about Nested Attributes on [Rails Docs](http://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html).  Do it!

The first thing we need to do is add the following to our Parent model:

```ruby
class Parent < ActiveRecord::Base
  has_many :children
  accepts_nested_attributes_for :children
end
```

Our new method in the `parents_controller.rb` is no different than normal:

```ruby
def new
  @parent = Parent.new
end
```
Our `new.html.erb` for Parent is a little different than what we've seen before. It looks like this:

```ruby
<%= form_for @parent do |f| %>
  <%= f.text_field :name, placeholder: "Name of Parent" %>
  <%= f.fields_for :children, @parent.children.build do |b| %>
    <%= b.text_field :name, placeholder: "Child's Name" %>
  <% end %>
  <%= f.submit %>
<% end %>
```

Lastly, we need to update our create method in our parents controller:

```ruby
def create
  @parent = Parent.create(params[:parent].permit(:name, :children_attributes=>[:name]))
  if @parent.save
    redirect_to @parent, notice: 'Parent was successfully created.'
  else
    render action: 'new'
  end
end
```

## A Small Example With the Bog

* Create The Comments Controller
	
	```
		rails g controller comments
	```
* Add the nested Resources and we forget about routes. Try rake routes.

	```
	resources :creatures do
		resources :comments
	end
	```

* Show a `creatures` comments

	```ruby
	class Comments < ApplicationController
	
		def index
			creature_id = params[:creature_id]
			@creature = Creature.find(creature_id)
			@comments = @creature.comments
		end
		...
	end
	```
* Create a new comment

	```ruby
	class Comments < ApplicationController
		
		...
		def new
			creature_id = params[:creature_id]
			@creature = Creature.find(creature_id)
			@comment = @creature.comments.new
		end
		...
	end
	```
	
	 and the `form_for` just takes two params now
	
	```rhtml
	<%= form_for([@creature, @comment]) do |f| %>
	  <%= f.text_field :title %><br>
	  <%= f.text_area :body %>
	  <%= f.submit %>
	<% end %>
	```
	
	handle creating the comment

	```ruby
	class Comments < ApplicationController
		
		...
		def create
			creature_id = params[:creature_id]
			@creature = Creature.find(creature_id)
			
			new_comment = params.require(:creature)
			@comment = @creature.comments.create(new_comment)
			redirect_to [@creature, @comment]
		end
		...
	end
	```
	




