import 'package:admin/components/sidebar.dart';
import 'package:admin/config/my_colors.dart';
import 'package:admin/models/rights_model.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/screens/roles/group_dropdownfield.dart';
import 'package:admin/screens/roles/role_textfield.dart';
import 'package:admin/services/right_service.dart';
import 'package:admin/services/roles_service.dart';
import 'package:admin/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddRolePage extends StatefulWidget {
  const AddRolePage({Key? key}) : super(key: key);

  @override
  State<AddRolePage> createState() => _AddRolePageState();
}

class _AddRolePageState extends State<AddRolePage> {
  final _formKey = GlobalKey<FormState>();
  final RolesService _rolesService = RolesService();
  final RightService _rightService = RightService();
  final TextEditingController _nameController = TextEditingController();
  String? _selectedGroup;
  List<RightsModel?>? _selectedValue;

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
                          RoleTextField(
                            label: 'Name',
                            errorMessage: 'Invalid name',
                            controller: _nameController,
                          ),
                          GroupDropdownfield(onSelectParam: (value) => setState(() => _selectedGroup = value)),
                          const SizedBox(height: 10,),
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
                                _rolesService.createGroupRole(
                                  _selectedGroup!,
                                  _nameController.text,
                                  _selectedValue!.map((value) => value!.id!).toList(),
                                );
                                Navigator.of(context).popAndPushNamed(Routes.roles);
                                setState(() {});
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: MyColors.light,
                              onPrimary: MyColors.blue,
                            ),
                            child: const Text(
                              'Create',
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