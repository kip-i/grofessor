import 'package:flutter/material.dart';



class YouApp extends StatelessWidget {
 const YouApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
           centerTitle: false,         //左寄せ
           backgroundColor:Colors.white.withOpacity(0.0),
           elevation:0.0,
          title: Text('時間割表',style:TextStyle(
                  color:Color.fromARGB(255, 10, 98, 11),
                  fontStyle:FontStyle.italic,
                  fontSize:30.0,
                  )),
                 
        ),
        body:        
         SingleChildScrollView(
          scrollDirection:Axis.vertical,
          child:FittedBox(child: MyDataTable(),)),
    ),
    );
  }
}



class MyDataTable extends StatefulWidget {
  @override
  _MyDataTableState createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  List<bool> _isSelected = List.generate(36, (index) => false);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      dataRowMaxHeight: 170.0,
      decoration: BoxDecoration(color: Color.fromARGB(255, 195, 199, 195)),
      columns: [
        DataColumn(label: Text('')),
        DataColumn(label: Text('  月', style: TextStyle(color: Color.fromARGB(255, 10, 98, 11), fontSize: 27))),
        DataColumn(label: Text('  火', style: TextStyle(color: Color.fromARGB(255, 10, 98, 11), fontSize: 27))),
        DataColumn(label: Text('  水', style: TextStyle(color: Color.fromARGB(255, 10, 98, 11), fontSize: 27))),
        DataColumn(label: Text('  木', style: TextStyle(color: Color.fromARGB(255, 10, 98, 11), fontSize: 27))),
        DataColumn(label: Text('  金', style: TextStyle(color: Color.fromARGB(255, 10, 98, 11), fontSize: 27))),
        DataColumn(label: Text('  土', style: TextStyle(color: Color.fromARGB(255, 10, 98, 11), fontSize: 27))),
      ],
      rows: List.generate(6, (rowIndex) {
        int startCellIndex = rowIndex * 6;
        return DataRow(
          color: MaterialStateProperty.resolveWith((states) {
            return Colors.white;
          }),
          cells: List.generate(7, (cellIndex) {
            if (cellIndex == 0) {
              return DataCell(Text('${rowIndex + 1}', style: TextStyle(color: Color.fromARGB(255, 10, 98, 11), fontSize: 28)));
            } else {
              int index = startCellIndex + cellIndex - 1;
              return DataCell(
                Transform.scale(
                  scale: 2.0,
                  child: Checkbox(
                    value: _isSelected[index],
                    onChanged: (bool? value) {
                      setState(() {
                        _isSelected[index] = value!;
                      });
                    },
                  ),
                ),
              );
            }
          }),
        );
      }),
    );
  }
}

  
  //_MyDataTableStateクラスの終わり
