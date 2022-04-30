import 'package:admin/config/my_colors.dart';
import 'package:admin/models/roles_model.dart';
import 'package:admin/services/roles_service.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class RoleDropdownfield extends StatefulWidget {
  final Function(String?) onSelectParam;
  const RoleDropdownfield({Key? key, required this.onSelectParam}) : super(key: key);

  @override
  _RoleDropdownfieldState createState() => _RoleDropdownfieldState();
}

class _RoleDropdownfieldState extends State<RoleDropdownfield> {
  final RolesService _rolesService = RolesService();

  List<DropdownMenuItem<String>> _generateItems(List<RolesModel> roles) {
    List<DropdownMenuItem<String>> items = [];

    for (RolesModel row in roles) {
     items.add(DropdownMenuItem<String>(
        value: row.id,
        child: Text(row.name!,),
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context){
    String? _selectedValue;
    
    return SizedBox(
      width: 300,
      child: FutureBuilder<List<RolesModel>>(
        future: _rolesService.fetchAllUsersRoles(),
        builder: (context, snapshot) {
          return DropdownButtonFormField2(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            isExpanded: true,
            hint: const Text(
              'Select a role',
              style: TextStyle(fontSize: 14),
            ),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: MyColors.dropDownArrow,
            ),
            iconSize: 30,
            buttonHeight: 60,
            buttonPadding: const EdgeInsets.only(left: 20, right: 10),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            items: _generateItems(snapshot.data ?? []),
            validator: (value) {
              if (value == null) return 'Please select a role';
              return null;
            },
            value: _selectedValue,
            onChanged: (value) {
              setState(() => _selectedValue = value.toString());
              widget.onSelectParam(_selectedValue);
            },
          );
        }
      ),
    );
  }
}