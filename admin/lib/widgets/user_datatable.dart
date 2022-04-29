import 'package:admin/models/db_user_model.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class UserDatatable extends StatefulWidget {
  final List<DbUserModel>? users;

  const UserDatatable({Key? key, this.users}) : super(key: key);

  @override
  _UserDatatableState createState() => _UserDatatableState();
}

class _UserDatatableState extends State<UserDatatable> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DataTable2(
            scrollController: ScrollController(),
            columnSpacing: 12,
            horizontalMargin: 12,
            minWidth: 200,
            columns: [
              const DataColumn2(
                label: Text('ID'),
                size: ColumnSize.L,
              ),
              const DataColumn(
                label: Text('UserId'),
              ),
              const DataColumn(
                label: Text('Role'),
              ),
              const DataColumn(
                label: Text('Image'),
              ),
            ],
            rows: List<DataRow>.generate(
              widget.users?.length ?? 0,
              (index) => DataRow(
                cells: [
                  DataCell(Text(widget.users![index].id ?? 'null')),
                  DataCell(Text(widget.users![index].userId ?? 'null')),
                  DataCell(Text(widget.users![index].role ?? 'null')),
                  DataCell(Text(widget.users![index].image?? 'null')),
                ]))),
        ],
      ),
    );
  }
}
