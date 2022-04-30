import 'package:admin/models/roles_model.dart';
import 'package:admin/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class RoleDatatable extends StatefulWidget {
  final List<RolesModel>? roles;

  const RoleDatatable({Key? key, this.roles}) : super(key: key);

  @override
  _RoleDatatableState createState() => _RoleDatatableState();
}

class _RoleDatatableState extends State<RoleDatatable> {

  List<DataRow> _generateDataCells(List<RolesModel>? roles) {
    List<DataRow> dataRows = [];
    for (RolesModel row in roles ?? []) {
      dataRows.add(DataRow2(
        onTap:() => Navigator.of(context).popAndPushNamed(Routes.rolesDetail, arguments: row),
        cells: [
          DataCell(Text(row.id ?? 'null')),
          DataCell(Text(row.name ?? 'null')),
          DataCell(Text(row.group!.name ?? 'null')),
          DataCell(Text(row.rights!.map((value) => value.action).toList().join(','))),
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
                label: Text('Name'),
              ),
              DataColumn(
                label: Text('Group'),
              ),
              DataColumn(
                label: Text('Rights'),
              ),
            ],
            rows: _generateDataCells(widget.roles)),
        ],
      ),
    );
  }
}