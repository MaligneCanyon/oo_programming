module Conversion
  def convert_temp(temp, units)
    temp *= (units.upcase == 'F' ? 2.0 : 0.5)
  end

  def convert_measure(ingred, factor)
    ingred *  factor
  end
end

class RecipeBook
  def initialize
    p @recipes = []
  end

  def get_recipe(new_recipe)
    @recipes << new_recipe
  end
end

class Recipe
  include Conversion

  def initialize(*ingreds)
    @ingredients = ingreds
  end

  def display_ingredients
    @ingredients
  end
end

class StarterRecipe < Recipe
end

class MainCourseRecipe < Recipe
end

class DesertRecipe < Recipe
end

class Ingredients
  include Conversion

  def initialize()
  end

  # def mix
  #   new_arr = []
  #   arr = ingredients.join.split
  #   until arr.empty?
  #     ndx = (0...arr_size).rand
  #     new_arr << arr.delete_at(ndx)
  #   end
  #   p new_arr.join
  # end
end

recipe_book = RecipeBook.new
recipe1 = Recipe.new('flour', 'water', 'sugar', 'spice')
p recipe1.display_ingredients
p recipe1.convert_measure('sugar', 3)
p recipe1.display_ingredients
p recipe_book.get_recipe(recipe1)
p recipe_book
