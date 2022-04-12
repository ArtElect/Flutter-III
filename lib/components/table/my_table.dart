import 'package:flutter/material.dart';
import 'package:flutter_iii/types/group.dart';
import 'package:flutter_iii/types/table_column.dart';

class MyTable extends StatefulWidget {
  const MyTable({Key? key}) : super(key: key);

  @override
  State<MyTable> createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  List<TableColumn> columns = TableColumn.getGroupTableColumn();
  List<Group> groups = Group.getGroups();
  List<Group> selected = [];
  bool isSorting = false;

  onSortGroupIdColumn(bool ascending) {
    if (ascending) {
      groups.sort((a, b) => a.id.compareTo(b.id));
    } else {
      groups.sort((a, b) => b.id.compareTo(a.id));
    }
  }

  onSelectedItem(bool? isSelected, Group group) async {
    setState(
      () => {
        if (isSelected == true)
          {selected.add(group)}
        else
          {selected.remove(group)}
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      showCheckboxColumn: true,
      columns: columns
          .map(
            (column) => DataColumn(
              numeric: column.isNumeric,
              label: Text(
                column.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          )
          .toList(),
      rows: groups
          .map(
            (group) => DataRow(
              selected: selected.contains(group),
              onSelectChanged: (status) => {onSelectedItem(status, group)},
              cells: [
                DataCell(Text(group.id.toString())),
                DataCell(Text(group.name)),
                DataCell(Text(group.numberOfMembers.toString())),
              ],
            ),
          )
          .toList(),
    );
  }
}
