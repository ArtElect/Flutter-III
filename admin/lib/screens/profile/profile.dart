import 'package:admin/components/sidebar.dart';
import 'package:admin/models/db_user_model.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/services/fire_auth.dart';
import 'package:admin/widgets/custom_app_bar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FireAuthService _fireAuthService = FireAuthService();
  late TextEditingController _imageController;
  late TextEditingController _firstnameController;
  late TextEditingController _lastnameController;
  late TextEditingController _pseudoController;


  @override
  void initState() {
    super.initState();
    _imageController = TextEditingController();
    _firstnameController = TextEditingController();
    _lastnameController = TextEditingController();
    _pseudoController = TextEditingController();
  }

  @override
  void dispose() {
    _imageController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _pseudoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: FutureBuilder<String>(
          future: _fireAuthService.getIdToken,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Row(
                children: [
                  const Sidebar(selectedIndex: 3),
                  Expanded(
                    child: FutureBuilder<DbUserModel> (
                        future: _fireAuthService.fetchCurrentDbUser(snapshot.data!),
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            return Center(
                              child: Card(
                                child: SizedBox(
                                  height: 500,
                                  width: 400,
                                  child: Column(
                                    children: [
                                      const Padding(padding: EdgeInsets.only(top: 10)),
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
                                        child: Text(
                                            "User id: " + snapshot.data!.userId!),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        padding: const EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15.0),
                                          border: Border.all(color: Colors.grey),
                                        ),
                                        child: Text("Role: " + snapshot.data!.role!),
                                      ),
                                      const Padding(padding: EdgeInsets.only(bottom: 10)),
                                      SizedBox(
                                        width: 300,
                                        child: TextField(
                                          controller: _firstnameController,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: snapshot.data!.firstname,
                                          ),
                                          keyboardType: TextInputType.phone,
                                        ),
                                      ),
                                      const Padding(padding: EdgeInsets.only(bottom: 10)),
                                      SizedBox(
                                        width: 300,
                                        child: TextField(
                                          controller: _lastnameController,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: snapshot.data!.lastname,
                                          ),
                                          keyboardType: TextInputType.phone,
                                        ),
                                      ),
                                      const Padding(padding: EdgeInsets.only(bottom: 10)),
                                      SizedBox(
                                        width: 300,
                                        child: TextField(
                                          controller: _pseudoController,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: snapshot.data!.pseudo,
                                          ),
                                          keyboardType: TextInputType.phone,
                                        ),
                                      ),
                                      const Padding(padding: EdgeInsets.only(bottom: 10)),
                                      SizedBox(
                                        width: 300,
                                        child: TextField(
                                          controller: _imageController,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: snapshot.data!.image,
                                          ),
                                          keyboardType: TextInputType.phone,
                                        ),
                                      ),
                                      const Padding(padding: EdgeInsets.only(bottom: 10)),
                                      ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              if (_imageController.text.isNotEmpty) {
                                                print("test");
                                              }
                                            });
                                          },
                                          child: const Text("Update"),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                              onPrimary: Colors.blue
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            print('${snapshot.error}');
                            return const Center(child: CircularProgressIndicator());
                          }
                        }
                        ),
                  )
                ],
              );
            } else {
              print('${snapshot.error}');
              return const Center(child: CircularProgressIndicator());
            }
          }
       ),
    );
  }
}