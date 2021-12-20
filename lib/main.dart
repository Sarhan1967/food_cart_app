
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:food_cart_app/bloc/cartListBloc.dart';
import 'package:food_cart_app/model/foodItem.dart';

import 'bloc/listStyleColorBloc.dart';
import 'cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return BlocProvider(//2-2 widget BlocProvider from materialApplication
      blocs: [
        Bloc ((i) => CartListBloc()),
        Bloc ((i) => ColorBloc())
      ],
      child: MaterialApp(//2-1 return materialApplication
        title: 'Food Cart',
        home: Home(),// 2-3 create Home class bellow
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class Home extends StatelessWidget {//2-4 override Home class
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(  //2-5 create Scaffold
      body: SafeArea(
        child: Container(
          child: ListView(
            children: <Widget>[
              FirstHalf(),                //2-8 FirstHalf()
              SizedBox(height: 20,),
              for (var foodItem in foodItemList.foodItems)
                ItemContainer(foodItem: foodItem) //3-1 ItemContainer------
              ,
            ],
          ),
        ),
      ),
    );
  }
}

//3-1 ItemContainer------
class ItemContainer extends StatelessWidget{
  final FoodItem foodItem;
  ItemContainer({this.foodItem});//constructor----

  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();//4-2------

  addToCart(FoodItem foodItem){bloc.addToList(foodItem);} //4-3 -------



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(// 3-2 GestureDetector-------
      onTap: () {
        addToCart(foodItem);//4-1----
        //4-4-----
        final snackbar = SnackBar(
          content: Text("${foodItem.title} added to the cart"),
          duration: Duration(milliseconds: 50),
        );
        Scaffold.of(context).showSnackBar(snackbar);
      },

      // 3-3 Items-------
      child: Items(
        hotel: foodItem.hotel,
        itemName: foodItem.title,
        itemPrice: foodItem.price,
        //imageUrl: foodItem.imgUrl,
        image: foodItem.image,
        leftAligned: (foodItem.id % 2 == 0) ? true : false,
      ),
    );
  }
}

// 3-4 Class Items-------
class Items extends StatelessWidget {

  final String hotel;
  final String itemName;
  final double itemPrice;
  //final String imageUrl;
  final Object image;
  final bool leftAligned;

  Items({
    @required this.hotel,
    @required this.itemName,
    @required this.itemPrice,
    //@required this.imageUrl,
    @required this.image,
    @required this.leftAligned,
  });

  // 3-5 Class Items-------
  @override
  Widget build(BuildContext context) {
    double containerPadding = 20;
    double containerBorderRadius = 10;

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: leftAligned ? 10 : containerPadding,
            right: leftAligned ? containerPadding : 10,
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                    left: leftAligned
                        ? Radius.circular(0)
                        : Radius.circular(containerBorderRadius),
                    right: leftAligned
                        ? Radius.circular(containerBorderRadius)
                        : Radius.circular(0),
                  ),
                  //child: Image.network(
                  child: Image.asset(
                    //imageUrl,
                    image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.only(
                  left: leftAligned ? 20 : 0,
                  right: leftAligned ? 0 : 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              itemName,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18
                              ),
                            ),
                          ),
                          Text(
                            "\$$itemPrice",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ]
                    ),
                    SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Colors.pinkAccent,
                                fontSize: 15
                            ),
                            children: [
                              TextSpan(text: "by "),
                              TextSpan(
                                  text: hotel,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  )
                              )
                            ]
                        ),
                      ),
                    ),
                    SizedBox(height: containerPadding,),

                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

//2-8 FirstHalf()
class FirstHalf extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.fromLTRB(35, 25, 0, 0),
      child: Column(
        children: <Widget>[
          CustomAppBar(),
          SizedBox(height: 10,),
          title(),//2-9title()---
          SizedBox(height: 10,),
          searchBar(),//2-10 searchBar()---
          SizedBox(height: 10,),
          categories(),// 2-11 categories()-----

        ],
      ),
    );
  }
}

Widget categories(){// 2-11 categories()-----
  return Container(
    height: 185,
    child: ListView(//2-12 CategoryListItem
      scrollDirection: Axis.horizontal,
      children: <Widget>[

        //2-13 CategoryListItems---------
        CategoryListItem(
          categoryIcon: Icons.bug_report,
          categoryName: "Burgers",
          availability: 12,
          selected: true,
        ),
        CategoryListItem(
          categoryIcon: Icons.bug_report,
          categoryName: "Pizza",
          availability: 12,
          selected: false,
        ),
        CategoryListItem(
          categoryIcon: Icons.bug_report,
          categoryName: "Rolls",
          availability: 12,
          selected: false,
        ),
        CategoryListItem(
          categoryIcon: Icons.bug_report,
          categoryName: "Burgers",
          availability: 12,
          selected: false,
        ),
        CategoryListItem(
          categoryIcon: Icons.bug_report,
          categoryName: "Burgers",
          availability: 12,
          selected: false,
        ),
      ],
    ),
  );
}
//2-10 searchBar()---
Widget searchBar(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Icon(
        Icons.search,
        color: Colors.black45,
      ),
      SizedBox(width: 20,),
      Expanded(
        child: TextField(
          decoration: InputDecoration(
              hintText: "Search....",
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              helperStyle: TextStyle(
                color: Colors.black87,
              )
          ),
        ),
      )
    ],

  );
}
//2-9 title()---
Widget title(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Text(
        "Food",
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 30
        ),
      ),
      Text(
        " Cart",
        style: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 30
        ),
      )
    ],
  );
}

//2-6 CustomAppBar
class CustomAppBar extends StatelessWidget {

  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();//4-5------

//2-7------
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.menu),
          StreamBuilder(//4-6 StreamBuilder --------
            stream: bloc.ListStream,
            builder: (context, snapshot) {
              List<FoodItem> foodItems = snapshot.data;
              int lenght = foodItems != null ? foodItems.length : 0;
              return buildGestureDetector(lenght, context, foodItems);//4-7 buildGestureDetector------
            },
          )
        ],
      ),
    );
  }
}

//4-7 buildGestureDetector------
GestureDetector buildGestureDetector(int length, BuildContext context ,List<FoodItem> foodItems) {
  return GestureDetector(
    onTap: () { //4-8 ----------followed by cart page
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Cart())
      );
    },
    child:  Container(
      margin: EdgeInsets.only(right: 30),
      child: Text(length.toString()),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.yellow[800], borderRadius: BorderRadius.circular(50)),
    ),
  );
}

//2-12 CategoryListItem
class CategoryListItem extends StatelessWidget {

  final IconData categoryIcon;
  final String categoryName;
  final int availability;
  final bool selected;

  CategoryListItem({
    @required this.categoryIcon,
    @required this.categoryName,
    @required this.availability,
    @required this.selected
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: selected ? Color(0xfffeb324) : Colors.white,
          border: Border.all(
            color: selected ? Colors.transparent : Colors.grey[200],
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[100],
                blurRadius: 15,
                offset: Offset(25,0),
                spreadRadius: 5
            )
          ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected ? Colors.transparent : Colors.grey,
                  width: 1.5,
                )
            ),
            child: Icon(
              categoryIcon,
              color: Colors.black,
              size: 30,
            ),
          ),
          SizedBox(height: 10,),
          Text(
            categoryName,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            width: 1.5,
            height: 15,
            color: Colors.black26,
          ),
          Text(
            availability.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
