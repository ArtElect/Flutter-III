import 'package:admin/models/roles_model.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class AssignedAccounts extends StatefulWidget {
  final RolesModel? role;

  const AssignedAccounts({Key? key, this.role}) : super(key: key);

  @override
  _AssignedAccountsState createState() => _AssignedAccountsState();
}

class _AssignedAccountsState extends State<AssignedAccounts> {

  List<DataRow> _generateDataCells(RolesModel? role) {
    List<DataRow> dataRows = [];

    for (RolesAccountsModel account in role?.account ?? []) {
      dataRows.add(DataRow2(
        cells: [
          DataCell(Text(account.userId ?? 'null')),
          DataCell(Text('${account.firstname} ${account.lastname}')),
          DataCell(Text(account.pseudo ?? 'null')),
          DataCell(Text(account.role ?? 'null')),
          DataCell(account.image != '' ? SizedBox(height: 40,child: Image.network(account.image!)) : const Text('No image uploaded')),
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
                label: Text('UserID'),
                size: ColumnSize.L,
              ),
              DataColumn(
                label: Text('Name'),
              ),
              DataColumn(
                label: Text('Pseudo'),
              ),
              DataColumn(
                label: Text('role'),
              ),
              DataColumn(
                label: Text('Image'),
              ),
            ],
            rows: _generateDataCells(widget.role)),
        ],
      ),
    );
  }
}