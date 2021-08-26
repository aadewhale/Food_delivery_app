import 'package:flutter/material.dart';
import 'package:myapp/provider/user.dart';
import 'package:myapp/screens/details.dart';
import 'package:myapp/provider/provider.dart';
import 'package:myapp/provider/product.dart';

import 'package:myapp/widgets/style.dart';
import 'package:myapp/widgets/validator.dart';
import 'package:provider/provider.dart';

import '../custom_text.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final SlidableController slidableController = SlidableController();
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final app = Provider.of<AppProvider>(context);
    final user = Provider.of<UserProvider>(context);

    return Expanded(
      child: Container(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: productProvider.productsByCategory.length,
            itemBuilder: (BuildContext context, int index) {
              return Stack(children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.black87,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 125,
                    ),
                  ),
                ),
                Slidable(
                  controller: slidableController,
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  actions: <Widget>[
                    SlideAction(
                      child: CircleAvatar(
                        backgroundColor: white,
                        child: Icon(
                          Icons.add,
                          color: red,
                          size: 28,
                        ),
                      ),
                    )
                  ],
                  secondaryActions: [
                    SlideAction(
                      onTap: () async {
                        app.changeLoading();
                        print("All set loading");

                        bool value = await user.addToCard(
                            product: productProvider.products[index],
                            quantity: 1);
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
                      child: CircleAvatar(
                        backgroundColor: white,
                        child: Icon(
                          Icons.add,
                          color: red,
                          size: 28,
                        ),
                      ),
                    )
                  ],
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Details(
                                    product: productProvider.products[index],
                                  )));
                    },
                    child: Card(
                      margin: EdgeInsets.only(bottom: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: white,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipPath(
                                clipper: MyCustomClipper(),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    app.images[index],
                                    width: 200,
                                    height: 130,
                                    fit: BoxFit.fill,
                                  ),
                                )),
                            Column(
                              children: [
                                CustomText(
                                  text:
                                      "${productProvider.products[index].name}",
                                  size: 22,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                CustomText(
                                  text:
                                      "${productProvider.products[index].subcategory}",
                                  weight: FontWeight.w300,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                CustomText(
                                    text:
                                        "\$${productProvider.products[index].price}"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]);
            }),
      ),
    );
  }
}
