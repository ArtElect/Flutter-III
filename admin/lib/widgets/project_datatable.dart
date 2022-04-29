import 'package:admin/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class ProjectDatatable extends StatefulWidget {
  final List<ProjectModel>? projects;

  const ProjectDatatable({Key? key, this.projects}) : super(key: key);

  @override
  _ProjectDatatableState createState() => _ProjectDatatableState();
}

class _ProjectDatatableState extends State<ProjectDatatable> {

  List<DataRow> _generateDataCells(List<ProjectModel>? projects) {
    List<DataRow> dataRows = [];

    for (var row in projects ?? []) {
      for (var project in row.projects ?? []) {
       dataRows.add(DataRow(
          cells: [
            DataCell(Text(row.id ?? 'null')),
            DataCell(Text(project.title ?? 'null')),
            DataCell(Text(project.description ?? 'null')),
            DataCell(Text(row.group.name ?? 'null')),
            DataCell(Text(project.image ?? 'null')),
          ]));
      }
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
                label: Text('title'),
              ),
              DataColumn(
                label: Text('description'),
              ),
              DataColumn(
                label: Text('group'),
              ),
              DataColumn(
                label: Text('image'),
              ),
            ],
            rows: _generateDataCells(widget.projects)),
        ],
      ),
    );
  }
}