import 'package:client/models/user_model.dart';
import 'package:client/routes/routes.dart';
import 'package:client/screens/mobile/drawer/navigation_drawer.dart';
import 'package:client/services/fire_auth.dart';
import 'package:client/services/profile.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:client/constant/my_colors.dart';

class SmallProfilePage extends StatefulWidget {
  const SmallProfilePage({ Key? key }) : super(key: key);

  @override
  _SmallProfilePageState createState() => _SmallProfilePageState();
}

class _SmallProfilePageState extends State<SmallProfilePage> {
  final ProfileService _profileService = ProfileService();
  final List<String> textFieldsValue = [];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawerEdgeDragWidth: 0,
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          backgroundColor: MyColors.appBarBgColor,
          title: const Text(
            'EPITECH',
            style: TextStyle(
              fontSize: 24,
              letterSpacing: 3,
            ),
          ),
        ),
        body: FutureBuilder<UserModel>(
            future: _profileService.getUserInformation(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return Center(
                  child: ListView(
                    controller: ScrollController(),
                    children: [
                      Form(
                        key: _formKey,
                          child: Column(
                            children: [
                            Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          snapshot.data!.image!),
                                    )
                                )
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Text("Id: " + snapshot.data!.id!),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Text("User Id: " + snapshot.data!.userId),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Text("Role: " + snapshot.data!.role),
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 20)),
                            SizedBox(
                              width: 300,
                              child: TextFormField(
                                initialValue: snapshot.data!.firstName,
                                decoration: InputDecoration(
                                  labelText: 'First Name',
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(Icons.person),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: MyColors.grey500),
                                    borderRadius: BorderRadius.circular(5.5),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: MyColors.grey500,
                                    ),
                                  ),
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a first name';
                                  }
                                  textFieldsValue.add(value);
                                  return null;
                                },
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 20)),
                            SizedBox(
                              width: 300,
                              child: TextFormField(
                                initialValue: snapshot.data!.lastName,
                                decoration: InputDecoration(
                                  labelText: 'Last Name',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(Icons.person),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: MyColors.grey500),
                                    borderRadius: BorderRadius.circular(5.5),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: MyColors.grey500,
                                    ),
                                  ),
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a last name';
                                  }
                                  textFieldsValue.add(value);
                                  return null;
                                },
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 20)),
                            SizedBox(
                              width: 300,
                              child: TextFormField(
                                initialValue: snapshot.data!.pseudo,
                                decoration: InputDecoration(
                                  labelText: 'Pseudo',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(Icons.person),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: MyColors.grey500),
                                    borderRadius: BorderRadius.circular(5.5),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: MyColors.grey500,
                                    ),
                                  ),
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a last name';
                                  }
                                  textFieldsValue.add(value);
                                  return null;
                                },
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 20)),
                            SizedBox(
                              width: 300,
                              child: TextFormField(
                                initialValue: snapshot.data!.image,
                                decoration: InputDecoration(
                                  labelText: 'Image',
                                  hintText: 'http://image.com',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(Icons.image),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: MyColors.grey500),
                                    borderRadius: BorderRadius.circular(5.5),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: MyColors.grey500,
                                    ),
                                  ),
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an image url';
                                  }
                                  textFieldsValue.add(value);
                                  return null;
                                },
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 20)),
                            GFButton(
                              text: "Update",
                              color: GFColors.PRIMARY,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  var res = await _profileService.updateCurrentAccount(
                                      textFieldsValue[0],
                                      textFieldsValue[1],
                                      textFieldsValue[2],
                                      textFieldsValue[3]
                                  );
                                  if (res) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Update successful')),
                                    );
                                  } else if (!res) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Update failed')),
                                    );
                                  } else {
                                    const CircularProgressIndicator();
                                  }
                                }
                              },
                            ),
                          ],
                        )
                      )
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }
        )
    );
  }
}