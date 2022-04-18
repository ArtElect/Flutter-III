class TableColumn {
  String name;
  bool isNumeric;

  TableColumn({
    required this.name,
    required this.isNumeric,
  });

  static List<TableColumn> getGroupTableColumn() {
    return <TableColumn>[
      TableColumn(name: "ID", isNumeric: true),
      TableColumn(name: "Name", isNumeric: false),
      TableColumn(name: "Number of members", isNumeric: true),
    ];
  }
}
