import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/provider/user.dart';
import 'package:myapp/screens/cart.dart';
import 'package:myapp/screens/login.dart';
import 'package:myapp/screens/order.dart';

import 'package:myapp/widgets/products.dart';

import 'package:myapp/custom_text.dart';

import 'package:myapp/provider/categoryProvider.dart';
import 'package:myapp/provider/product.dart';
import 'package:myapp/provider/provider.dart';

import 'package:myapp/widgets/style.dart';

import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<String> _locations = ['A', 'B', 'C'];

  String? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);

    final categoryProvider = Provider.of<CategoryProvider>(context);
    final app = Provider.of<AppProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    productProvider.loadProductsByCategory(
        categoryName: categoryProvider.categories[_selectedIndex].name);
    authProvider.reloadUserModel();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: black),
        title: DropdownButtonHideUnderline(
          child: DropdownButton(
              underline: null,
              hint: Text(
                "Location",
              ),
              value: _selectedLocation,
              onChanged: (newValue) {
                setState(() {
                  _selectedLocation = newValue as String?;
                });
              },
              items: _locations.map((location) {
                return DropdownMenuItem(
                  child: Text(location),
                  value: location,
                );
              }).toList()),
        ),
        centerTitle: true,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20.0, bottom: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.black45),
            height: 50,
            width: 50,
            child: Icon(
              Icons.person,
              size: 50,
            ),
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      drawer: Drawer(
        elevation: 13.0,
        child: ListView(
          children: <Widget>[
            Container(
              height: 150,
              color: red,
              child: Row(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                      text:
                          authProvider.userModel?.username ?? 'Name loading...',
                      color: white,
                      weight: FontWeight.bold,
                      size: 18,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: CustomText(
                        text:
                            authProvider.userModel?.email ?? 'Email loading...',
                        color: white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 120,
                  child: Stack(
                    children: [
                      Positioned(
                        child: CircleAvatar(
                            radius: 50,
                            child: app.image != null
                                ? ClipOval(
                                    child: Image.file(
                                    app.image!,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ))
                                : Icon(
                                    Icons.person,
                                    size: 70,
                                  )),
                      ),
                      Positioned(
                        top: 50,
                        left: 70,
                        child: CircleAvatar(
                          backgroundColor: white,
                          child: IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('choose a picture'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: [
                                              Divider(
                                                height: 1,
                                              ),
                                              ListTile(
                                                onTap: () async {
                                                  app.openGallery();
                                                  Navigator.of(context).pop();
                                                },
                                                title: Text("Gallery"),
                                                leading:
                                                    Icon(Icons.account_box),
                                              ),
                                              Divider(
                                                height: 1,
                                              ),
                                              ListTile(
                                                onTap: () async {
                                                  app.openCamera();
                                                },
                                                title: Text("Camera"),
                                                leading: Icon(Icons.camera),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              icon: Icon(Icons.add_a_photo)),
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.home),
              title: CustomText(text: "Home"),
            ),
            ListTile(
              onTap: () async {
                await authProvider.getOrders();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrdersScreen()));
              },
              leading: Icon(Icons.bookmark_border),
              title: CustomText(text: "My orders"),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
              leading: Icon(Icons.shopping_cart),
              title: CustomText(text: "Cart"),
            ),
            ListTile(
              onTap: () async {
                await authProvider.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              leading: Icon(Icons.exit_to_app),
              title: CustomText(text: "Log out"),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Hello, Jenny',
              size: 26,
              weight: FontWeight.w200,
            ),
            RichText(
                text: TextSpan(
                    text: 'Best Food for ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                  TextSpan(
                    text: 'you',
                    style: TextStyle(color: Colors.red),
                  )
                ])),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: grey),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      autofocus: false,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (pattern) {},
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        hintText: "Search",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: red,
                  ),
                  padding: EdgeInsets.all(15),
                  child: Icon(Icons.filter_list_outlined),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: 50,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryProvider.categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                          ),
                          margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          child: ElevatedButton.icon(
                            autofocus: true,
                            onPressed: () async {
                              _onSelected(index);

                              // setState(() {
                              //   _hasBeenPressed = !_hasBeenPressed;
                              // });
                              await productProvider.loadProductsByCategory(
                                  categoryName:
                                      categoryProvider.categories[index].name);
                            },
                            icon: ImageIcon(AssetImage(app.icon[index])),
                            label: Text(
                              categoryProvider.categories[index].name,
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (states) {
                                if (states.contains(MaterialState.pressed))
                                  return Colors.red;
                                return _selectedIndex == index
                                    ? Colors.red
                                    : Colors.grey.shade200;
                              }),
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (states) {
                                if (states.contains(MaterialState.pressed))
                                  return Colors.red;
                                return Colors.grey;
                              }),
                              foregroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (states) {
                                if (states.contains(MaterialState.selected))
                                  return Colors.white;
                                return Colors.black;
                              }),
                            ),
                          )),
                    );
                  }),
            ),
            SizedBox(
              height: 15,
            ),
            Products()
          ],
        ),
      ),
    );
  }
}
