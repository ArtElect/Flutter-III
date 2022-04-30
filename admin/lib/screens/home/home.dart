import 'package:admin/components/sidebar.dart';
import 'package:admin/models/db_user_model.dart';
import 'package:admin/services/fire_auth.dart';
import 'package:admin/services/user_service.dart';
import 'package:admin/screens/home/user_datatable.dart';
import 'package:admin/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FireAuthService _fireAuthService = FireAuthService();
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawerEdgeDragWidth: 0,
      appBar: const CustomAppBar(),
      body: FutureBuilder<String>(
        future: _fireAuthService.getIdToken,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Row(
              children: [
                const Sidebar(selectedIndex: 0,),
                Flexible(
                  child: FutureBuilder<List<DbUserModel>>(
                    future: _userService.getAccounts(),
                    builder: (context, snapshot) {
                      if(snapshot.data != null) {
                        return Column(
                          children: [
                            Container(
                              width: size.width*0.6,
                              child: SingleChildScrollView(
                                controller: ScrollController(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 10),
                                    Row(
                                      children: const [
                                        SizedBox(width: 20),
                                        Text('Users', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                    UserDatatable(users: snapshot.data),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }
                  ),
                ),
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