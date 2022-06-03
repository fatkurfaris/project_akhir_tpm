class Recipe {
  int? id;
  String? title;
  String? image;
  int? readyInMinutes;
  bool? vegetarian;
  double? healthScore;

  Recipe(
      // constructor
      {this.id,
      this.title,
      this.image,
      this.readyInMinutes,
      this.vegetarian,
      this.healthScore});

  factory Recipe.fromMap(Map<String, dynamic> map) {
    //mendapatkan data dari API
    return Recipe(
        id: map['id'], //nama harus sama dengan nama pada API
        title: map['title'],
        image: map['image'],
        readyInMinutes: map['readyInMinutes'],
        vegetarian: map['vegetarian']);
    // healthScore: map['healthScore']);
  }
}

class ListofRecipe {
  // membuat list dari resep
  List<Recipe>? recipelist;

  ListofRecipe({this.recipelist}); // constructor

  factory ListofRecipe.fromMap(Map<String, dynamic> map) {
    return ListofRecipe(recipelist: generatelist(map));
  }
}

List<Recipe> generatelist(Map<String, dynamic> map) {
  // return list resep ke recipelist
  List<Recipe> emptylist = [];
  for (var item in map['results'] ?? []) {
    Recipe recipepicker =
        Recipe.fromMap(item); //generate Recipe dalam objek sebagai recipepicker
    emptylist.add(recipepicker);
  }

  return emptylist;
}

// For Recipe Steps

class Steps {
  int? number;
  String? step;

  Steps(
      { //constructor
      this.number,
      this.step});

  factory Steps.fromMap(Map<String, dynamic> map) {
    return Steps(number: map['number'], step: map['step']);
  }
}

class RecipeSteps {
  List<Steps>? stepslist; // membuat variable sebagai 'stepslist'

  RecipeSteps({this.stepslist});

  factory RecipeSteps.fromMap(Map<String, dynamic> map) {
    return RecipeSteps(stepslist: generatesteplist(map));
  }
}

List<Steps> generatesteplist(Map<String, dynamic> map) {
  // fungsi untuk steplist

  List<Steps> Blanklist = [];

  for (var item in map['steps']) {
    // melooping variabel steps

    Steps STEP = Steps.fromMap(item);
    Blanklist.add(STEP);
  }
  return Blanklist;
}
