import 'package:admin/components/sidebar.dart';
import 'package:admin/config/my_colors.dart';
import 'package:admin/models/rights_model.dart';
import 'package:admin/models/roles_model.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/screens/roles/assigned_accounts.dart';
import 'package:admin/services/right_service.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:admin/services/roles_service.dart';
import 'package:admin/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class RoleDetailPage extends StatefulWidget {
  final RolesModel? role;
  const RoleDetailPage({Key? key, required this.role}) : super(key: key);

  @override
  _RoleDetailPageState createState() => _RoleDetailPageState();
}

class _RoleDetailPageState extends State<RoleDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final RolesService _rolesService = RolesService();
  final RightService _rightService = RightService();
  List<RightsModel?>? _selectedValue;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Row(
        children: [
          const Sidebar(selectedIndex: 3),
          Flexible(
            child: Column(
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
                            Text('Accounts assigned to this role', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                          ],
                        ),
                        AssignedAccounts(role: widget.role),
                        Center(
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
                                      FutureBuilder<List<RightsModel>>(
                                        future: _rightService.fetchRights(),
                                        builder: (context, snapshot) {
                                          if (snapshot.data != null) {
                                            return MultiSelectChipField<RightsModel?>(
                                              title: const Text("Select rights"),
                                              headerColor: MyColors.light,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: MyColors.light, width: 1.8),
                                              ),
                                              selectedChipColor: MyColors.lightPurple,
                                              items: snapshot.data!.map((right) => MultiSelectItem<RightsModel?>(right, right.action!)).toList(),
                                              onTap: (values) => _selectedValue = values,
                                            );
                                          }
                                          return const Center(child: CircularProgressIndicator());
                                        }
                                      ),
                                      const SizedBox(height: 40,),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!.validate()) {
                                            _rolesService.updateGorupRole(
                                              _selectedValue!.map((value) => value!.id!).toList(),
                                              widget.role!.id!,
                                            );
                                            Navigator.of(context).popAndPushNamed(Routes.roles);
                                            setState(() {});
                                          }
                                        },
                                        child: const Text("Update"),
                                        style: ElevatedButton.styleFrom(
                                          primary: MyColors.light,
                                          onPrimary: MyColors.blue,
                                        )
                                      ),
                                      const SizedBox(height: 10,),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _rolesService.deleteRole(widget.role!.id!);
                                            Navigator.of(context).popAndPushNamed(Routes.roles);
                                          });
                                        },
                                        child: const Text("Delete"),
                                        style: ElevatedButton.styleFrom(
                                          primary: MyColors.light,
                                          onPrimary: MyColors.red,
                                        )
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Assign role'),
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).popAndPushNamed(Routes.assignRole);
        }
      ),
    );
  }
}