import 'package:flutter/material.dart';
import 'package:trial/model/user.dart';
import 'package:trial/services/database_handler.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'SQLite Tutorial'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DatabaseHandler handler;
  String name = '';
  String age = '';
  String id = '';
  String country = '';
  String email = '';

  //List<User> listOfUser = [];
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final idController = TextEditingController();
  final countryController = TextEditingController();
  final emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHandler();
    this.handler.initializeDB().whenComplete(() async {
      print("initialized");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title!),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
            Widget>[
          Form(
            key: _formStateKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 10.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter amount';
                      }
                      if (value.trim() == "") {
                        return "Only space is not Valid!!!";
                      }
                      return null;
                    },
                    controller: idController,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.greenAccent,
                            width: 2.0,
                            style: BorderStyle.solid),
                      ),
                      labelText: "Id",
                      fillColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 10.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter amount';
                      }
                      if (value.trim() == "") {
                        return "Only space is not Valid!!!";
                      }
                      return null;
                    },
                    controller: nameController,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.greenAccent,
                            width: 2.0,
                            style: BorderStyle.solid),
                      ),
                      labelText: "Name",
                      fillColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 10.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter amount';
                      }
                      if (value.trim() == "") {
                        return "Only space is not Valid!!!";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: ageController,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.greenAccent,
                            width: 2.0,
                            style: BorderStyle.solid),
                      ),
                      labelText: "Age",
                      fillColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 10.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter amount';
                      }
                      if (value.trim() == "") {
                        return "Only space is not Valid!!!";
                      }
                      return null;
                    },
                    controller: countryController,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.greenAccent,
                            width: 2.0,
                            style: BorderStyle.solid),
                      ),
                      labelText: "Country",
                      fillColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 10.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter amount';
                      }
                      if (value.trim() == "") {
                        return "Only space is not Valid!!!";
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.greenAccent,
                            width: 2.0,
                            style: BorderStyle.solid),
                      ),
                      labelText: "Email",
                      fillColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        name = nameController.text;
                        age = ageController.text;
                        id = idController.text;
                        country = countryController.text;
                        email = emailController.text;
                      });
                      // this.handler.insertdata(User(
                      //     id: 0, name: '', age: 0, country: '', email: '')); //failed
                      // this.handler.insertUser(User(age: 0, country: '', name: ''));
                      var re = await addUsers();
                      print(re);
                      // this.handler.insertUser(listOfUser);
                    },
                    child: Text('Add')),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: this.handler.retrieveUsers(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Icon(Icons.delete_forever),
                          ),
                          key: ValueKey<int>(snapshot.data![index].id!),
                          onDismissed: (DismissDirection direction) async {
                            await this
                                .handler
                                .deleteUser(snapshot.data![index].id!);
                            setState(() {
                              snapshot.data!.remove(snapshot.data![index]);
                            });
                          },
                          child: Card(
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: <Widget>[
                                      Text(snapshot.data![index].id.toString()),
                                      Text(snapshot.data![index].name),
                                      Text(
                                          snapshot.data![index].age.toString()),
                                      Text(snapshot.data![index].country),
                                      Text(snapshot.data![index].email
                                          .toString()),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ));
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ]));
  }

  Future<int> addUsers() async {
    User firstUser = User(
      name: name,
      age: int.parse(age),
      country: country,
      email: email,
    );

    List<User> listOfUsers = [firstUser];
    print(listOfUsers);
    return await this.handler.insertUser(listOfUsers);
  }
}
