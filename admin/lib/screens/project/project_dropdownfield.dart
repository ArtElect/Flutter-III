import 'package:admin/models/groups_model.dart';
import 'package:admin/services/group_service.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class ProjectDropdownfield extends StatefulWidget {
  final Function(String?) onSelectParam;
  const ProjectDropdownfield({Key? key, required this.onSelectParam}) : super(key: key);

  @override
  _ProjectDropdownfieldState createState() => _ProjectDropdownfieldState();
}

class _ProjectDropdownfieldState extends State<ProjectDropdownfield> {
  final GroupService _groupService = GroupService();

  List<DropdownMenuItem<String>> _generateItems(List<GroupsModel> groups) {
    List<DropdownMenuItem<String>> items = [];

    for (GroupsModel group in groups) {
     items.add(DropdownMenuItem<String>(
        value: group.id,
        child: Text(group.name!,),
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context){
    String? _selectedValue;
    
    return SizedBox(
      width: 300,
      child: FutureBuilder<List<GroupsModel>>(
        future: _groupService.fetchGroups(),
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
              'Select a group',
              style: TextStyle(fontSize: 14),
            ),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Color.fromARGB(115, 83, 68, 68),
            ),
            iconSize: 30,
            buttonHeight: 60,
            buttonPadding: const EdgeInsets.only(left: 20, right: 10),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            items: _generateItems(snapshot.data ?? []),
            validator: (value) {
              if (value == null) return 'Please select a group';
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