import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../db/category.dart';
import '../db/brand.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController quatityController = TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];

  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];

  String _currentCategory;
  String _currentBrands;

  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;

  List<String> selectedSize = <String>[];

  File _image1;
  File _image2;
  File _image3;

  @override
  void initState() {
    _getCategories();
    _getBrands();
  }

  List<DropdownMenuItem<String>> getcategoriesDropDown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < categories.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(categories[i].data['category']),
                value: categories[i].data['category']));
      });
    }
    return items;
  }

  List<DropdownMenuItem<String>> getBrandsDropDown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < brands.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(brands[i].data['brands']),
                value: brands[i].data['brands']));
      });
    }
    return items;
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
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                        borderSide: BorderSide(
                          color: grey.withOpacity(0.5),
                          width: 2.5,
                        ),
                        onPressed: () {
                          _selectImage(
                              ImagePicker.pickImage(
                                  source: ImageSource.gallery),
                              1);
                        },
                        child: _displayChild1(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                        borderSide: BorderSide(
                          color: grey.withOpacity(0.5),
                          width: 2.5,
                        ),
                        onPressed: () {
                          _selectImage(
                              ImagePicker.pickImage(
                                  source: ImageSource.gallery),
                              2);
                        },
                        child: _displayChild2(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                        borderSide: BorderSide(
                          color: grey.withOpacity(0.5),
                          width: 2.5,
                        ),
                        onPressed: () {
                          _selectImage(
                              ImagePicker.pickImage(
                                  source: ImageSource.gallery),
                              3);
                        },
                        child: _displayChild3(),
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

              //  ========= select category ===========

              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Category: ',
                      style: TextStyle(color: red),
                    ),
                  ),
                  DropdownButton(
                    items: categoriesDropDown,
                    onChanged: changeSelectedCategory,
                    value: _currentCategory,
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Brand: ',
                      style: TextStyle(color: red),
                    ),
                  ),
                  DropdownButton(
                    items: brandsDropDown,
                    onChanged: changeSelectedBrand,
                    value: _currentBrands,
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: quatityController,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    hintText: "Quantity",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "you must enter the Quantity";
                    }
                  },
                ),
              ),
              Text('Available Size'),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: selectedSize.contains('XS'),
                    onChanged: (value) => changeSelectedSize('XS'),
                  ),
                  Text('XS'),
                  Checkbox(
                    value: selectedSize.contains('S'),
                    onChanged: (value) => changeSelectedSize('S'),
                  ),
                  Text('S'),
                  Checkbox(
                    value: selectedSize.contains('M'),
                    onChanged: (value) => changeSelectedSize('M'),
                  ),
                  Text('M'),
                  Checkbox(
                    value: selectedSize.contains('L'),
                    onChanged: (value) => changeSelectedSize('L'),
                  ),
                  Text('L'),
                  Checkbox(
                    value: selectedSize.contains('XL'),
                    onChanged: (value) => changeSelectedSize('XL'),
                  ),
                  Text('XL'),
                  Checkbox(
                    value: selectedSize.contains('XXL'),
                    onChanged: (value) => changeSelectedSize('XXL'),
                  ),
                  Text('XXL'),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: selectedSize.contains('28'),
                    onChanged: (value) => changeSelectedSize('28'),
                  ),
                  Text('28'),
                  Checkbox(
                    value: selectedSize.contains('30'),
                    onChanged: (value) => changeSelectedSize('30'),
                  ),
                  Text('30'),
                  Checkbox(
                    value: selectedSize.contains('32'),
                    onChanged: (value) => changeSelectedSize('32'),
                  ),
                  Text('32'),
                  Checkbox(
                    value: selectedSize.contains('34'),
                    onChanged: (value) => changeSelectedSize('34'),
                  ),
                  Text('34'),
                  Checkbox(
                    value: selectedSize.contains('36'),
                    onChanged: (value) => changeSelectedSize('36'),
                  ),
                  Text('36'),
                  Checkbox(
                    value: selectedSize.contains('38'),
                    onChanged: (value) => changeSelectedSize('38'),
                  ),
                  Text('38'),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: selectedSize.contains('40'),
                    onChanged: (value) => changeSelectedSize('40'),
                  ),
                  Text('40'),
                  Checkbox(
                    value: selectedSize.contains('42'),
                    onChanged: (value) => changeSelectedSize('42'),
                  ),
                  Text('42'),
                  Checkbox(
                    value: selectedSize.contains('44'),
                    onChanged: (value) => changeSelectedSize('44'),
                  ),
                  Text('44'),
                  Checkbox(
                    value: selectedSize.contains('46'),
                    onChanged: (value) => changeSelectedSize('46'),
                  ),
                  Text('46'),
                  Checkbox(
                    value: selectedSize.contains('48'),
                    onChanged: (value) => changeSelectedSize('48'),
                  ),
                  Text('48'),
                  Checkbox(
                    value: selectedSize.contains('50'),
                    onChanged: (value) => changeSelectedSize('50'),
                  ),
                  Text('50'),
                ],
              ),
              FlatButton(
                color: red,
                textColor: white,
                child: Text('add product'),
                onPressed: () {
                  validateAndUpload();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getCategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    print(data.length);
    setState(() {
      categories = data;
      categoriesDropDown = getcategoriesDropDown();
      _currentCategory = categories[0].data['category'];
    });
  }

  _getBrands() async {
    List<DocumentSnapshot> data = await _brandService.getBrands();
    print(data.length);
    setState(() {
      brands = data;
      brandsDropDown = getBrandsDropDown();
      _currentBrands = brands[0].data['brand'];
    });
  }

  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory = selectedCategory);
  }

  changeSelectedBrand(String selectedBrand) {
    setState(() => _currentBrands = selectedBrand);
  }

  void changeSelectedSize(String size) {
    if (selectedSize.contains(size)) {
      setState(() {
        selectedSize.remove(size);
      });
    } else {
      setState(() {
        selectedSize.insert(0, size);
      });
    }
  }

  void _selectImage(Future<File> pickImage, int imageNumber) async {
    File tempImg = await pickImage;
    switch (imageNumber) {
      case 1:
        setState(() => _image1 = tempImg);
        break;
      case 2:
        setState(() => _image2 = tempImg);
        break;
      case 3:
        setState(() => _image3 = tempImg);
        break;
    }
  }

  Widget _displayChild1() {
    if (_image1 == null) {
      return Padding(
        padding: EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        _image1,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Widget _displayChild2() {
    if (_image2 == null) {
      return Padding(
        padding: EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(_image2, fit: BoxFit.fill, width: double.infinity);
    }
  }

  Widget _displayChild3() {
    if (_image3 == null) {
      return Padding(
        padding: EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(_image3, fit: BoxFit.fill, width: double.infinity);
    }
  }

  void validateAndUpload() async{
    if (_formKey.currentState.validate()) {
      if (_image1 != null && _image2 != null && _image3 != null) {
        if (selectedSize.isNotEmpty) {
          String imageUrl1;
          String imageUrl2;
          String imageUrl3;

          final FirebaseStorage storage = FirebaseStorage.instance;
          final String picture1 = "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task1 =  storage.ref().child(picture1).putFile(_image1);
          final String picture2 = "2${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task2 =  storage.ref().child(picture2).putFile(_image2);
          final String picture3 = "3${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task3 =  storage.ref().child(picture3).putFile(_image3);

          StorageTaskSnapshot snapshot1 = await task1.onComplete.then((snapshot) => snapshot);
          StorageTaskSnapshot snapshot2 = await task2.onComplete.then((snapshot) => snapshot);

          task3.onComplete.then((snapshot3) async{
            imageUrl1 = await snapshot1.ref.getDownloadURL();
            imageUrl2 = await snapshot2.ref.getDownloadURL();
            imageUrl3 = await snapshot3.ref.getDownloadURL();
          });
        } else {
          Fluttertoast.showToast(msg: 'select at least one size');
        }
      } else {
        Fluttertoast.showToast(msg: 'all the images must be  provided');
      }
    }
  }
}
// 16:23