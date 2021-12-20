//followed by cartlistBloc page
import 'package:meta/meta.dart';

FoodItemList foodItemList = FoodItemList(foodItems: [//1-5---
  FoodItem(
    id: 1,
    title: "Beach BBQ Burger",
    hotel: "Las Vegas Hotel",
    price: 14.49,
    image: 'assets/plate1.png',
    //imgUrl:
    //"https://hips.hearstapps.com/pop.h-cdn.co/assets/cm/15/05/480x240/54ca71fb94ad3_-_5summer_skills_burger_470_0808-de.jpg",
  ),
  FoodItem(
    id: 2,
    title: "Kick Ass Burgers",
    hotel: "Dudleys",
    price: 11.99,
    image: 'assets/plate2.png',
    //imgUrl:
    //"https://b.zmtcdn.com/data/pictures/chains/8/18427868/1269c190ab2f272599f8f08bc152974b.png",
  ),
  FoodItem(
    id: 3,
    title: "xx Pizza Burger",
    hotel: "Golf Course",
    price: 8.49,
    image: 'assets/plate3.png',
    //imgUrl: "https://www.qsrmagazine.com/sites/default/files/styles/story_page/public/FreddysBurger.jpg",
  ),
  FoodItem(
    id: 4,
    title: "Chilly Cheeze Burger",
    hotel: "Las Vegas Hotel",
    price: 14.49,
    image: 'assets/plate4.png',
    //imgUrl: "https://image.insider.com/5613ebd59dd7cc1d008bfa6b?width=700&format=jpeg&auto=webp",
  ),
  FoodItem(
    id: 5,
    title: "Beach BBQ Burger",
    hotel: "Las Vegas Hotel",
    price: 14.49,
    image: 'assets/plate5.png',
    //imgUrl: "https://www.beliefnet.com/columnists/doinglifetogether/wp-content/uploads/sites/258/2013/05/burger.jpg",
  ),
  FoodItem(
    id: 6,
    title: "Beach BBQ Burger",
    hotel: "Las Vegas Hotel",
    price: 14.49,
    image: 'assets/plate6.png',
    //imgUrl:
   //"https://cdn.pixabay.com/photo/2018/03/04/20/08/burger-3199088__340.jpg",
  ),
]);

class FoodItemList {//1-4----------
  List<FoodItem> foodItems;//followed by 1-5-----
  FoodItemList({@required this.foodItems});//--constructor---
}

class FoodItem {//1-1---foodItem-------
  int id;
  String title;
  String hotel;
  double price;
  Object image;
  int quantity;
  FoodItem({ @required this.id,@required this.title,@required this.hotel,@required this.price, @required this.image,this.quantity = 1  });//--constructor---

  void incrementQuantity( ) {//1-2------------
    this.quantity = this.quantity + 1;
  }

  void decrementQuantity( ) {//1-3------------
    this.quantity = this.quantity - 1;
  }
}
