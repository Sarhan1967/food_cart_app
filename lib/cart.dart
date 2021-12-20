
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:food_cart_app/bloc/cartListBloc.dart';
import 'package:food_cart_app/model/foodItem.dart';

import 'bloc/listStyleColorBloc.dart';

class Cart extends StatelessWidget {//5-1--------

  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();//5-2----------

  @override
  Widget build(BuildContext context) {
    List<FoodItem> foodItems;

    // TODO: implement build
    return StreamBuilder(
      stream: bloc.ListStream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          foodItems = snapshot.data;
          return Scaffold(
            body: SafeArea(
              child: Container(
                child: CartBody(foodItems),//5-3 CartBody-------
              ),
            ),
            bottomNavigationBar: BottomBar(foodItems),// 6-2 bottomNavigationBar---------
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class BottomBar extends StatelessWidget{// 6-2 bottomNavigationBar---------
  final List<FoodItem> foodItems;

  BottomBar(this.foodItems);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      margin: EdgeInsets.only(left: 35, bottom: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          totalAmount(foodItems) ,// 6-3 totalAmount---------
          Divider(//6-5 Divider ----------
            height: 10,
            color: Colors.red[700],
          ),
          persons(),//6-6 persons()-------
          nextButtonBar(),//6-8 nextButtonBar()-------
        ],
      ),
    );
  }

  Container nextButtonBar() {//6-8 nextButtonBar()-------
    return Container(
      margin: EdgeInsets.only(right: 25),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Color(0xfffeb324),
          borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "15-25 min",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800
            ),
          ),
          Text(
            "Next",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900
            ),
          )
        ],
      ),
    );
  }

  Container persons() {//6-6 persons()-------
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Persons",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700
            ),
          ),
          CustomPersonWidget()// 6-7 totalAmount---------
        ],
      ),
    );
  }

  Container totalAmount(List<FoodItem> foodItem) {// 6-3 totalAmount---------
    return Container (
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Total",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500
            ),
          ),
          Text(
            "\$${returnTotalAmount(foodItem)}",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22
            ),

          )
        ],
      ),
    );
  }

  String returnTotalAmount(List<FoodItem> foodItem){// 6-4 totalAmount---------
    double totalAmount = 0;
    for (int i =0; i < foodItem.length; i ++){
      totalAmount = totalAmount + foodItem[i].price * foodItem[i].quantity;
    }
    return totalAmount.toStringAsFixed(2);
  }
}



class CustomPersonWidget extends StatefulWidget{// 6-7 totalAmount---------
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CustomPersonWidgetState();
  }
}


class _CustomPersonWidgetState extends State<CustomPersonWidget> {
  // 6-6 totalAmount---------

  int noOfPersons = 1;
  double buttonWidth = 30;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(right: 25),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.purple [600], width: 2),
          borderRadius: BorderRadius.circular(20)
      ),
      padding: EdgeInsets.symmetric(vertical: 5),
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            width: buttonWidth,
            height: buttonWidth,
            child: FlatButton(
              child: Text(
                "-",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              onPressed: (){
                setState(() {
                  noOfPersons--;
                });
              },
            ),
          ),
          Text(
            noOfPersons.toString(),
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20
            ),
          ),
          SizedBox(
            width: buttonWidth,
            height: buttonWidth,
            child: FlatButton(
              child: Text(
                "+",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              onPressed: (){
                setState(() {
                  noOfPersons++;
                });

              },
            ),
          ),
        ],
      ),

    );
  }
}

//5-3 CartBody-------
class CartBody extends StatelessWidget {

  final List<FoodItem> foodItems;

  CartBody(this.foodItems);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.fromLTRB(35, 40, 25, 0),
      child: Column(
        children: <Widget>[
          CustomAppBar(),//5-4 CustomAppBar()-------
          title(),
          Expanded(
            flex: 1,
            child: foodItems.length > 0 ? foodItemsList() : noItemsContainer(),
          )
        ],
      ),
    );
  }

  Container noItemsContainer() {// 5-6 ---------
    return Container(
      child: Center(
        child: Text(
          "No more items in the cart",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[500],
              fontSize: 20
          ),
        ),
      ),
    );
  }

  ListView foodItemsList(){// 5-7 ---------
    return ListView.builder(
        itemCount: foodItems.length,
        itemBuilder: (builder, index) {
          return CartListItem(foodItem: foodItems[index]);
        }
    );
  }

  Widget title () {//5-5 title --------
    return Padding(
      //padding: EdgeInsets.symmetric(vertical: 35),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "My ",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 35,
                ),
              ),
              Text(
                "Order",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 35,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

}

class CartListItem extends StatelessWidget {// 5-8 ---------

  final FoodItem foodItem;

  CartListItem({@required this.foodItem});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    /*return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: ItemContent(foodItem: foodItem),
    );*/
    return Draggable(
      data: foodItem,
      maxSimultaneousDrags: 1,
      child: DraggableChild(foodItem: foodItem,),
      feedback: DraggableChildFeedback(foodItem: foodItem,),
      childWhenDragging: foodItem.quantity > 1 ? DraggableChild(foodItem: foodItem,) : Container(),
    );
  }
}


class DraggableChild extends StatelessWidget {
  const DraggableChild({
    Key key,
    @required this.foodItem,
  }) : super(key: key);

  final FoodItem foodItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: ItemContent(
        foodItem: foodItem,
      ),
    );
  }
}

class DraggableChildFeedback extends StatelessWidget {
  const DraggableChildFeedback({
    Key key,
    @required this.foodItem,
  }) : super(key: key);

  final FoodItem foodItem;

  @override
  Widget build(BuildContext context) {

    final ColorBloc colorBloc = BlocProvider.getBloc<ColorBloc>();

    return  Opacity(
      opacity: 0.7,
      child: Material(
        child: StreamBuilder(
          stream: colorBloc.colorStream,
          builder: (context, snapshot) {
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              child: ItemContent(
                foodItem: foodItem,
              ),
              decoration: BoxDecoration(
                  color: snapshot.data != null ? snapshot.data : Colors.white
              ),
            );
          },
        ),
      ),
    );
  }
}



class ItemContent extends StatelessWidget {// 5-9 ---------

  final FoodItem foodItem;

  ItemContent({@required this.foodItem});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      //child: Row(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            //child: Image.network(
            child: Image.asset(
              // foodItem.imgurl,
              foodItem.image,
              fit: BoxFit.fitHeight,
              height: 55,
              width: 80,
            ),
          ),
          RichText(
            text: TextSpan(
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.purple,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(text: foodItem.quantity.toString()),
                  TextSpan(text: " X "),
                  TextSpan(text: foodItem.title)
                ]
            ),
          ),
          Text(
            "\$${foodItem.quantity * foodItem.price}",
            style: TextStyle(
                color: Colors.greenAccent[300],
                fontWeight: FontWeight.w400
            ),
          )
        ],
      ),
    );
  }
}




//5-4 CustomAppBar()-------
class CustomAppBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5),
          child: GestureDetector(
            child: Icon(
              CupertinoIcons.back,
              size: 30,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        DragTargetWidget(),
      ],
    );
  }
}

class DragTargetWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DragTargetWidgetState();
  }
}

class _DragTargetWidgetState extends State<DragTargetWidget>  {

  final CartListBloc listBloc = BlocProvider.getBloc<CartListBloc>();
  final ColorBloc colorBloc = BlocProvider.getBloc<ColorBloc>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DragTarget<FoodItem>(
      onWillAccept: (FoodItem foodItem) {
        colorBloc.setColor(Colors.red);
        return true;
      },
      onAccept: (FoodItem foodItem) {
        listBloc.removeFromList(foodItem);
        colorBloc.setColor(Colors.greenAccent);
      },
      onLeave: (FoodItem foodItem) {
        colorBloc.setColor(Colors.white);
      },
      builder: (context, incoming, rejected) {
        return GestureDetector(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Icon(
              CupertinoIcons.delete,
              size: 35,
            ),
          ),
          onTap: () {

          },
        );
      },
    );
  }
}
