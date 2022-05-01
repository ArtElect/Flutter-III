import 'package:admin/models/groups_model.dart';
import 'package:admin/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class GroupDatatable extends StatefulWidget {
  final List<GroupsModel> groups;

  const GroupDatatable({Key? key, required this.groups}) : super(key: key);

  @override
  _GroupDatatableState createState() => _GroupDatatableState();
}

class _GroupDatatableState extends State<GroupDatatable> {

  List<DataRow2> _generateDataCells(List<GroupsModel>? groups) {
    List<DataRow2> dataRows = [];

    for (GroupsModel group in groups ?? []) {
      dataRows.add(DataRow2(
        onTap:() => Navigator.of(context).popAndPushNamed(Routes.groupDetail, arguments: group),
        cells: [
          DataCell(Text(group.id ?? 'null')),
          DataCell(Text(group.name ?? 'null')),
          DataCell(Text(group.description ?? 'null')),
          DataCell(group.image != '' ? SizedBox(height: 40,child: Image.network(group.image!)) : const Text('No image uploaded')),
        ]));
    }
    return dataRows;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DataTable2(
            empty: const Text('No data', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            scrollController: ScrollController(),
            columnSpacing: 12,
            horizontalMargin: 12,
            minWidth: 200,
            columns: const [
              DataColumn2(
                label: Text('ID'),
                size: ColumnSize.L,
              ),
              DataColumn(
                label: Text('name'),
              ),
              DataColumn(
                label: Text('description'),
              ),
              DataColumn(
                label: Text('image'),
              ),
            ],
            rows: _generateDataCells(widget.groups)),
        ],
      ),
    );
  }
}