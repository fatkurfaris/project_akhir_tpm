import 'package:flutter/material.dart';
import 'package:project_resep/models/Recipeview.dart';
import 'package:project_resep/models/secondpage.dart';
import 'package:project_resep/services/fetching.dart';

// ignore: must_be_immutable
class Recipetile extends StatefulWidget {
  Recipetile(
      {Key? key,
      this.title,
      this.readyInMinutes,
      this.vegetarian,
      this.healthScore,
      this.id,
      this.image})
      : super(key: key);
  int? id;
  String? title;
  String? image;
  int? readyInMinutes;
  bool? vegetarian;
  double? healthScore;
  @override
  _RecipetileState createState() => _RecipetileState();
}

class _RecipetileState extends State<Recipetile> {
  void recipeinfo() async {
    Recipe recipedetail;
    RecipeSteps listofSteps;
    print('Recipe tile pressed');
    recipedetail = await fetchinginformation(widget.id!);
    listofSteps = await fetchingsteps(widget.id!);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Searchresult(
                  recipedetail: recipedetail,
                  listofSteps: listofSteps,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        return recipeinfo();
      },
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: Container(
                height: 150,
                width: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(widget.image!)),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: Text(
                widget.title!,
                style: TextStyle(
                    fontFamily: "Merienda_One",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),

            // Image.network(widget.image!),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchvalue = TextEditingController();

  List<Widget> searchresult = [];

  void searchfunction() async {
    // ignore: non_constant_identifier_names
    ListofRecipe RECIPES;
    RECIPES = await fetchinglist(searchvalue.text);

    setState(() {
      print('search functino called');
      searchresult.clear();
      for (Recipe item in RECIPES.recipelist ?? []) {
        searchresult.add(Recipetile(
            title: item.title,
            image: item.image,
            id: item.id,
            readyInMinutes: item.readyInMinutes,
            vegetarian: item.vegetarian,
            healthScore: item.healthScore));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      'lib/models/images/532e23c344e1214f28d59f640ceb58b1.jpg'),
                  fit: BoxFit.fill)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 70),
                Text(
                  "Want to Cook Something",
                  style: TextStyle(
                      fontFamily: "Pacifico",
                      color: Colors.grey.shade900,
                      fontSize: 30,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 5),
                  child: Text(
                    "We are here to help you. Search for any Recipe you want to make. Type the name of any Dish or integredient.",
                    style: TextStyle(
                      fontFamily: "Merienda_One",
                      color: Colors.brown.shade700,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40, top: 7),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchvalue,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: "Type here (Eg: Chicken)",
                            hintStyle: TextStyle(color: Colors.grey),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black87),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black87),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          searchfunction();
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Icon(Icons.search, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30),
                ...searchresult,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
