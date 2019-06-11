import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            image_location: 'image/cat/3.png',
            image_caption: 'Dress',
          ),
          Category(
            image_location: 'image/cat/6.png',
            image_caption: 'Shoes',
          ),
          Category(
            image_location: 'image/cat/17.png',
            image_caption: 'T-shirt',
          ),
          Category(
            image_location: 'image/cat/14.png',
            image_caption: 'Formal',
          ),
          Category(
            image_location: 'image/cat/10.png',
            image_caption: 'In-formal',
          ),
          Category(
            image_location: 'image/cat/13.png',
            image_caption: 'Pants',
          ),
          Category(
            image_location: 'image/cat/21.png',
            image_caption: 'Gless',
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location; // image
  final String image_caption; // name of image
  Category({
    this.image_caption,
    this.image_location,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 100.0,
          child: ListTile(
            title: Image.asset(
              image_location,
              width: 100.0,
              height: 80.0,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(image_caption),
            )
          ),
        ),
      ),
    );
  }
}
