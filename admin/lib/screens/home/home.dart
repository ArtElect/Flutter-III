import 'package:admin/components/sidebar.dart';
import 'package:admin/config/my_colors.dart';
import 'package:admin/models/db_user_model.dart';
import 'package:admin/services/fire_auth.dart';
import 'package:admin/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FireAuthService _fireAuthService = FireAuthService();

  userRedirection() {
    print("test");
  }

  @override
  Widget build(BuildContext context){
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
                Expanded(
                  child: Container(
                    child: FutureBuilder<List<DbUserModel>> (
                        future: _fireAuthService.getAccounts(snapshot.data!),
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            return Container(
                              child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: userRedirection,
                                      child: Row(
                                          children: [
                                            Container(
                                                width: 100.0,
                                                height: 100.0,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(snapshot.data![index].image!),
                                                    )
                                                )
                                            ),
                                            Text(snapshot.data![index].id.toString()),
                                          ],
                                        )
                                    );
                                  }
                              )
                            );
                          } else {
                            print('${snapshot.error}');
                            return const Center(child: CircularProgressIndicator());
                          }
                        }
                    )
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