# More on Nested Resources

If you're still a bit confused. These additional notes on Nested Resources may help.

### Resources

Instead of recreating all our routes from scratch everytime we create a rails controller and model it would be nice if they could easily be created for us.

[resources](http://guides.rubyonrails.org/routing.html#crud-verbs-and-actions)


### Nested Resources

Here a good example of an API that uses RESTful routing for multiple resources, [Google Blog API](https://developers.google.com/blogger/docs/3.0/getting_started).

Nested resources allow us to build out URL structure between two related models, and still maintain a RESTful convention.

It's common to have resources that are logically children of other resources. For example, suppose your application includes these models:

```ruby
class Magazine < ActiveRecord::Base
  has_many :ads
end

class Ad < ActiveRecord::Base
  belongs_to :magazine
end
```

```ruby
class Good < ActiveRecord::Base
  has_many :bids
end

class Bid < ActiveRecord::Base
  belongs_to :good
end
```

### Create an Association

We need a model to associate with our bog creatures. We generate the model as follows

```
rails g model comment title body creature:references
rake db:migrate
```

We then setup the association in the models.

```ruby
class Creature < ActiveRecord::Base
  has_many :comments
end

class Comments < ActiveRecord::Base
  belongs_to :creature
end
```

Let's add some more seed data

`db/seeds.rb`

```ruby
yoda = Creature.create({name: "Yoda", description: "little green man"})
luke = Creature.create({name: "Luke", description: "Young Jedi"})
vader = Creature.create({name: "Darth Vader", description: "Father of luke"})

luke.comments.create({title: "hmmm", body: "you must unlearn what you have learned"});
luke.comments.create({title: "Oh wow", body: "jedi's rock"})

comment = Comment.create({title: "Darkside!", body: "give into your anger"})
vader.comments << comment
```



#### A Look At Nested Resources

Nested routes allow us to capture this association between the two models.  In our `routes.rb` file, we could add:

```ruby
resources :magazines do
  resources :ads
end
```

The resulting routes look something like this:

![Screen Shot 2014-05-12 at 8.01.46 PM.png](https://draftin.com:443/images/15047?token=vsc-fjd0kcprAUpmuTddwH5EkT18m3LJFi3eEg0m8pnmyIgtAQiB_EItqtJttyTufonbuqEZ11hggEwYazfQOec)

For more information, read the Rails Guide, [Rails Routing from the Inside Out](http://guides.rubyonrails.org/routing.html)

##Simple Nested Routes and Forms Example

Suppose we have 2 models, Parent and Child.  Each of the models have a name (string) attribute.  The Child model also has a parent_id (integer) attribute  The model associations are as follows:

```ruby
class Parent < ActiveRecord::Base
  has_many :children
end

class Child < ActiveRecord::Base
  belongs_to :parent
end
```
To set up our nested routes, we add the following to our `routes.rb` file:

```ruby
resources :parents do
  resources :children
end
```

Now we'll have routes like `parents/4/children` and `parents/2/children/3/edit` set up for us.

Our Parent controller is straightforward.  It is no different from any of the other simple controllers we've written before.

Things start to change a little bit in the `children_controller.rb`.  Remember that our routes look like `parents/:parent_id/children`, where each child belongs to a specific parent. In each method, we first look up the correct Parent using `params[:parent_id]` before we do anything with Child.


```ruby
class ChildrenController < ApplicationController

  def index
    @parent= Parent.find(params[:parent_id])
    @children = @parent.children.all
  end


  def show
    @parent = Parent.find(params[:parent_id])
    @child = @parent.children.find(params[:id])
  end

  def new
    @parent = Parent.find(params[:parent_id])
    @child = @parent.children.new
  end

  def edit
    @parent = Parent.find(params[:parent_id])
    @child = @parent.children.find(params[:id])
  end

  def create
    @parent = Parent.find(params[:parent_id])
    @child = @parent.children.new(child_params)

      if @child.save
        redirect_to [@parent, @child]
      else
        render action: 'new'
      end
  end


  def update
    @parent = Parent.find(params[:parent_id])
    @child = @parent.children.find(params[:id])
      if @child.update(child_params)
        redirect_to [@parent, @child]
      else
       render action: 'edit'
      end
  end


  def destroy
    @parent = Parent.find(params[:parent_id])
    @child = @parent.children.find(params[:id])
    @child.destroy
    redirect_to parent_children_path(@parent)
  end

  private
    def child_params
      params.require(:child).permit(:name)
    end
end
```

The views for `index` and `show` are self-explanatory.   However, the `new` and `edit` forms look slightly different that what we're used to.

```rhtml
<%= form_for([@parent, @child]) do |f| %>
  <%= f.label :name %><br>
  <%= f.text_field :name %>
  <%= f.submit %>
<% end %>
```

Notice that the form requires 2 models, a Parent and a Child.  That's really the only difference.  Remember that in this case we're not creating/editing a Parent; we're only creating/editing a Child, which belongs to a Parent.