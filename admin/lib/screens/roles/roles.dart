import 'package:admin/components/sidebar.dart';
import 'package:admin/models/roles_model.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/screens/roles/role_datatable.dart';
import 'package:admin/services/roles_service.dart';
import 'package:admin/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({ Key? key }) : super(key: key);

  @override
  _RolesPageState createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  final RolesService _rolesService = RolesService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Row(
        children: [
          const Sidebar(selectedIndex: 3),
          Flexible(
            child: FutureBuilder<List<RolesModel>>(
              future: _rolesService.fetchAllUsersRoles(),
              builder: (context, snapshot) {
                if(snapshot.data != null) {
                  return Column(
                    children: [
                      SizedBox(
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
                                  Text('Roles', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                                ],
                              ),
                              RoleDatatable(roles: snapshot.data!),
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
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).popAndPushNamed(Routes.addRoles);
        }
      ),
    );
  }
}