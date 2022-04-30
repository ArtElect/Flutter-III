import 'package:admin/components/sidebar.dart';
import 'package:admin/config/my_colors.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/screens/roles/account_dropdownfield.dart';
import 'package:admin/screens/roles/group_dropdownfield.dart';
import 'package:admin/screens/roles/role_dropdownfield.dart';
import 'package:admin/services/roles_service.dart';
import 'package:admin/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class AssignRolePage extends StatefulWidget {
  const AssignRolePage({ Key? key }) : super(key: key);

  @override
  _AssignRolePageState createState() => _AssignRolePageState();
}

class _AssignRolePageState extends State<AssignRolePage> {
  final _formKey = GlobalKey<FormState>();
  final RolesService _rolesService = RolesService();
  String? _selectedRole;
  String? _selectedAccount;
  //List<RightsModel?>? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Row(
        children: [
          const Sidebar(selectedIndex: 3),
          Flexible(
            child: Center(
              child: GFCard(
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            "https://logowik.com/content/uploads/images/flutter5786.jpg"),
                        )
                      )
                    ),
                    const SizedBox(height: 30,),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          RoleDropdownfield(onSelectParam: (value) => setState(() => _selectedRole = value)),
                          const SizedBox(height: 10,),
                          AccountDropdownfield(onSelectParam: (value) => setState(() => _selectedAccount = value)),
                          const SizedBox(height: 40,),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _rolesService.assignGroupRoleToUser(
                                  _selectedRole!,
                                  _selectedAccount!,
                                );
                                Navigator.of(context).popAndPushNamed(Routes.roles).then((value) => setState(() {}));
                                setState(() {});
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: MyColors.light,
                              onPrimary: MyColors.blue,
                            ),
                            child: const Text(
                              'Assign',
                              style: TextStyle(fontWeight: FontWeight.bold,),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}