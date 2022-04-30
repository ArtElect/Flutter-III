import 'package:admin/components/sidebar.dart';
import 'package:admin/models/db_user_model.dart';
import 'package:admin/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class UserInformationPage extends StatefulWidget {
  final DbUserModel dbUserModel;

  UserInformationPage({Key? key, required this.dbUserModel}) : super(key: key);

  @override
  _UserInformationPageState createState() => _UserInformationPageState();
}

class _UserInformationPageState extends State<UserInformationPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawerEdgeDragWidth: 0,
      appBar: const CustomAppBar(),
      body: Row(
        children: [
          const Sidebar(selectedIndex: 0),
          Expanded(
              child: Center(
                child: Card(
                child: SizedBox(
                  height: 400,
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
                                image: NetworkImage(widget.dbUserModel.image!),
                              )
                          )
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Text("Id: " + widget.dbUserModel.id!),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Text("User id: " + widget.dbUserModel.userId!),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Text("Role: " + widget.dbUserModel.role!),
                      ),
                    ],
                  ),
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}