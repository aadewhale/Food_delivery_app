import 'package:flutter/material.dart';
import 'package:myapp/custom_text.dart';
import 'package:myapp/model/products.dart';

import 'package:myapp/provider/app.dart';
import 'package:myapp/provider/user.dart';

import 'package:myapp/widgets/style.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  final ProductModel product;
  const Details({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;
  final _key = GlobalKey<ScaffoldState>();

  var controller;

  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    final app = Provider.of<AppProvider>(context);

    return Scaffold(
        key: _key,
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    padding: EdgeInsets.all(15),
                    minWidth: 8,
                    child: const Icon(
                      Icons.arrow_back,
                      color: white,
                      size: 30.0,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: red,
                  ),
                  MaterialButton(
                    padding: EdgeInsets.all(15),
                    minWidth: 8,
                    child: isLiked
                        ? Icon(
                            Icons.favorite,
                            size: 30.0,
                            color: white,
                          )
                        : Icon(
                            Icons.favorite_outline,
                            size: 30.0,
                            color: white,
                          ),
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: red,
                  ),
                ],
              ),
              Image.asset("assets/images/Burger5.jpg"),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: widget.product.name,
                    size: 22,
                  ),
                  CustomText(
                      text: "\$${(widget.product.price).ceil().toDouble()}"),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Text(
                  "${widget.product.subcategory}",
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star),
                  CustomText(text: "\(${widget.product.rating.toDouble()})")
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text("${widget.product.description}",
                  style: TextStyle(fontWeight: FontWeight.w300, height: 2.0)),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: red),
                        color: red,
                        borderRadius: BorderRadius.circular(25)),
                    child: Row(children: [
                      IconButton(
                          icon: Icon(
                            Icons.remove,
                            size: 36,
                            color: white,
                          ),
                          onPressed: () {
                            if (quantity != 1) {
                              setState(() {
                                quantity -= 1;
                              });
                            }
                          }),
                      CustomText(
                        text: "$quantity ",
                        color: white,
                        size: 25,
                        weight: FontWeight.w300,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.add_circle_sharp,
                            size: 36,
                            color: white,
                          ),
                          onPressed: () {
                            setState(() {
                              quantity += 1;
                            });
                          }),
                    ]),
                  ),
                  GestureDetector(
                    onTap: () async {
                      app.changeLoading();
                      print("All set loading");

                      bool value = await user.addToCard(
                          product: widget.product, quantity: quantity);
                      if (value) {
                        print("Item added to cart");

                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Added ro Cart!")));
                        user.reloadUserModel();
                        app.changeLoading();

                        return;
                      } else {
                        app.changeLoading();

                        print("Item NOT added to cart");
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(40, 15, 40, 15),
                      decoration: BoxDecoration(
                          border: Border.all(color: red),
                          color: red,
                          borderRadius: BorderRadius.circular(25)),
                      child: CustomText(
                        text: "Place Order",
                        color: white,
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
