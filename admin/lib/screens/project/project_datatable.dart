import 'package:admin/models/groups_model.dart';
import 'package:admin/models/project_model.dart';
import 'package:admin/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class ProjectDatatable extends StatefulWidget {
  final List<GroupsModel> groups;

  const ProjectDatatable({Key? key, required this.groups}) : super(key: key);

  @override
  _ProjectDatatableState createState() => _ProjectDatatableState();
}

class _ProjectDatatableState extends State<ProjectDatatable> {

  List<DataRow2> _generateDataCells(List<GroupsModel>? groups) {
    List<DataRow2> dataRows = [];

    for (GroupsModel group in groups ?? []) {
      for (ProjectModel project in group.projects ?? []) {
        dataRows.add(DataRow2(
          onTap:() => Navigator.of(context).popAndPushNamed(Routes.projectDetail, arguments: project),
          cells: [
            DataCell(Text(project.projectId ?? 'null')),
            DataCell(Text(project.title ?? 'null')),
            DataCell(Text(project.description ?? 'null')),
            DataCell(Text(group.name ?? 'null')),
            DataCell(project.image != '' ? SizedBox(height: 40,child: Image.network(project.image!)) : const Text('No image uploaded')),
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
            rows: _generateDataCells(widget.groups)),
        ],
      ),
    );
  }
}