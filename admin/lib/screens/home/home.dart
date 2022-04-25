import 'package:admin/components/sidebar.dart';
import 'package:admin/config/my_colors.dart';
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawerEdgeDragWidth: 0,
      appBar: const CustomAppBar(),
      body: FutureBuilder<String>(
        future: _fireAuthService.getIdToken,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            print(snapshot.data);
            return Row(
              children: [
                const Sidebar(selectedIndex: 0,),
                Expanded(
                  child: Container(),
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