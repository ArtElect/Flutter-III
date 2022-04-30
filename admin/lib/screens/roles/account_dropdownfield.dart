import 'package:admin/config/my_colors.dart';
import 'package:admin/models/db_user_model.dart';
import 'package:admin/services/user_service.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class AccountDropdownfield extends StatefulWidget {
  final Function(String?) onSelectParam;
  const AccountDropdownfield({Key? key, required this.onSelectParam}) : super(key: key);

  @override
  _AccountDropdownfieldState createState() => _AccountDropdownfieldState();
}

class _AccountDropdownfieldState extends State<AccountDropdownfield> {
  final UserService _userService = UserService();

  List<DropdownMenuItem<String>> _generateItems(List<DbUserModel> users) {
    List<DropdownMenuItem<String>> items = [];

    for (DbUserModel row in users) {
     items.add(DropdownMenuItem<String>(
        value: row.id,
        child: Text(row.pseudo!,),
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context){
    String? _selectedValue;
    
    return SizedBox(
      width: 300,
      child: FutureBuilder<List<DbUserModel>>(
        future: _userService.getAccounts(),
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
              'Select a user',
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
              if (value == null) return 'Please select a user';
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