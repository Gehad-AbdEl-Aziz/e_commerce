import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../db/category.dart';
import '../db/brand.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();

  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
  <DropdownMenuItem<String>>[];

  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];

  String _currentCategory;
  String _currentBrands;

  Color white = Colors.white;
  Color black = Colors.black;
  Color gray = Colors.grey;
  Color red = Colors.red;
  @override
  void initState() {
    _getCategories();
    //_getBrands();
    getcategoriesDropDown();
    print(categoriesDropDown.length);
    //_currentCategory= categoriesDropDown[0].value;
  }

  getcategoriesDropDown() {
    for (int i = 0; i< categories.length; i++){
      setState(() {
        categoriesDropDown.insert(0, DropdownMenuItem(child: Text(categories[i]['category']),
          value: categories[i]['category'],));
      });
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: white,
        leading: Icon(
          Icons.close,
          color: black,
        ),
        title: Text(
          "add product",
          style: TextStyle(color: black),
        ),
      ),
      body: Form(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlineButton(
                      borderSide: BorderSide(
                        color: gray.withOpacity(0.5),
                        width: 2.5,
                      ),
                      onPressed: () {
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
                        child: Icon(
                          Icons.add,
                          color: gray,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlineButton(
                      borderSide: BorderSide(
                        color: gray.withOpacity(0.5),
                        width: 2.5,
                      ),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
                        child: Icon(
                          Icons.add,
                          color: gray,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlineButton(
                      borderSide: BorderSide(
                        color: gray.withOpacity(0.5),
                        width: 2.5,
                      ),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
                        child: Icon(
                          Icons.add,
                          color: gray,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "enter a product name with 10 characters at maxmum",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: red,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: productNameController,
                decoration: InputDecoration(
                  hintText: "Product Name",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "you must enter the product name";
                  } else if (value.length > 10) {
                    return " the product name cant have more than 10 letters";
                  }
                },
              ),
            ),
            //  select category
            Visibility(
                visible: _currentCategory != null,
                child: InkWell(
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    color: red,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Text(_currentCategory ?? "null",style: TextStyle(color: white),),
                          ),
                          IconButton(icon: Icon(Icons.close,color: white,), onPressed: (){
                              setState(() {
                                _currentCategory = '';
                              });
                          }),
                        ],
                      ),
                    ),
                  ),
                )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                      autofocus: true,
                      decoration: InputDecoration(
                          hintText: 'Add Category',
                      )
                  ),
                  suggestionsCallback: (pattern) async {
                    return await _categoryService.getSuggestions(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      leading: Icon(Icons.category),
                      title: Text(suggestion['category']),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      _currentCategory = suggestion['category'];
                    });
                  },
                ),
              ),
            ),

            //  select brand
            Visibility(
                visible: _currentBrands != null,
                child: InkWell(
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    color: red,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Text(_currentBrands ?? "null",style: TextStyle(color: white),),
                          ),
                          IconButton(icon: Icon(Icons.close,color: white,), onPressed: (){
                            setState(() {
                              _currentBrands = '';
                            });
                          }),
                        ],
                      ),
                    ),
                  ),
                )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Add Brand',
                      )
                  ),
                  suggestionsCallback: (pattern) async {
                    return await _brandService.getSuggestions(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      leading: Icon(Icons.category),
                      title: Text(suggestion['brand']),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      _currentBrands = suggestion['brand'];
                    });
                  },
                ),
              ),
            ),
            /*FlatButton(
              color: red,
                textColor: white,
                onPressed: (){},
                child: Text('add product')),*/
          ],
        ),
      ),
    );
  }

  void _getCategories() async{
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    print(data.length);
    setState(() {
      categories = data;
      //_currentCategory = categories[0].data['category'];
      print(categories.length);
    });
  }

  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory=selectedCategory);
  }
}
