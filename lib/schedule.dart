import 'package:flutter/material.dart';

class NextSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '時間割表',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      
    );
  }

}
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('時間割表'),
      ),
      body: Center(
        child: DataTable(
          columns: [
            DataColumn(label: Text('月')),
            DataColumn(label: Text('火')),
            DataColumn(label: Text('水')),
            DataColumn(label: Text('木')),
            
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text('')),
              DataCell(Text('')),
              DataCell(Text('')),
              DataCell(Text('')),
              
            ]),
            DataRow(cells: [
              DataCell(Text('')),
              DataCell(Text('')),
              DataCell(Text('')),
              DataCell(Text('')),
            ]),
            DataRow(cells: [
              DataCell(Text('')),
              DataCell(Text('')),
              DataCell(Text('')),
              DataCell(Text('')),
            ]),
            
            
          ],
        ),
      ),
    );
  }
}
