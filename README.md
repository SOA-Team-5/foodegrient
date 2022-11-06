# Foodegrient
Want to parse a list of ingredients within a recipe? Or are you looking for a random food joke? These are just two of many endpoints provided by the marvelous [Spoonacular](https://spoonacular.com/) food and recipes API.

## Resourse

* Search Recipes by Ingredients
* Wine Pairing
* Dish Pairing for Wine
* Wine Recommendation
* Detect Food in Text
* Search Menu Items
* Get Menu Item Information
## Elements

* Search Recipes by Ingredients()
    *  image
    *  likes
    *  title
    *  name
    *  original
* Wine Pairing(Find a wine that goes well with a food. Food can be a dish name ("steak"), an ingredient name "salmon", or a cuisine "italian")
    *  pairedWines
    *  pairingText
* Dish Pairing for Wine(Find a dish that goes well with a given wine)
    *  pairings
    *  text
* Wine Recommendation
    *  title
    *  averageRating
    *  description
    *  imageUrl
    *  price
    *  ratingCount
    *  score
 * Detect Food in Text
    *  annotation
    *  image
    *  tag
 * Search Menu Items
    *  title
    *  restaurantChain
    *  image
    *  servings
        *  number
        *  size
        *  unit
    * totalMenuItems
 *  Get Menu Item Information
    *  title
    *  restaurantChain
    *  nutritions
    *  caloricBreakdown
    *  likes
    *  servings
    *  price
    *  spoonacularScore
## Elements
   These are objects that are important to the project
   * Recipes(aka Search Recipes by Ingredients)
   * wine(aka Wine Pairing/Dish Pairing for Wine and Wine Recommendation)
   * misc(aka Detect Food in Text)
   * menu(aka Search Menu Items and Get Menu Item Information)

## Entity-Relationship Diagram
<img width="441" alt="1" src="https://user-images.githubusercontent.com/84471360/200188632-75bb77c3-a7ab-4b56-bbd0-847516249de5.png">
