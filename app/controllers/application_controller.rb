class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!

  # new page '/recipes/new'
    # responds with a 200 status code
    # contains a form to create the recipe (inside the new.erb)
    # posts the form back to create a new recipe
  get '/recipes/new' do
    erb :new
  end

  # creating a new recipe
    # creates a new recipe and saves to the database
    # redirects to the recipe show page (works combined with the get 'recipes/:id')
  post '/recipes' do
    @recipe = Recipe.find_or_create_by(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect to "/recipes/#{@recipe.id}"
  end

  # show page '/recipes/:id'
    # responds with a 200 status code
    # displays the recipe's name
    # displays the recipe's ingredients
    # displays the recipe's cook time
    # contains a form to delete the recipe
    # deletes via a DELETE request
  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  # edit page '/recipes/:id/edit'
    # responds with a 200 status code
    # contains a form to edit the recipe (inside the edit.erb)
    # displays the recipe's ingredients before editing
    # submits via a patch request
  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  # updating a recipe
    # updates the recipe
    # redirects to the recipe show page (works combined with the get 'recipes/:id')
  patch '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    
    redirect to "/recipes/#{@recipe.id}"
  end

  # Index page '/recipes'
    # responds with a 200 status code
    # displays a list of recipes (inside index.erb)
    # contains links to each recipe's show page (inside index.erb)
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end
  
  # deleting a recipe
    # deletes a recipe
  delete '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete

    redirect to '/recipes'
  end

end