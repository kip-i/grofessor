import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class YourApp extends StatelessWidget {
  const YourApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white.withOpacity(0.0),
          elevation: 0.0,
          title: Text(
            '時間割表',
            style: TextStyle(
              color: Color.fromARGB(255, 10, 98, 11),
              fontStyle: FontStyle.italic,
              fontSize: 33.0,
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FittedBox(
            child: MyDataTable(),
          ),
        ),
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
  List<String> _startTimes = List.generate(36, (index) => '');
  List<String> _endTimes = List.generate(36, (index) => '');

  // New lists to store selected times for left column cells
  List<String> _leftColumnStartTimes = List.generate(6, (index) => '');
  List<String> _leftColumnEndTimes = List.generate(6, (index) => '');

  @override
  Widget build(BuildContext context) {
    return DataTable(
      dataRowMaxHeight: 190.0,
      decoration: BoxDecoration(color: Color.fromARGB(255, 195, 199, 195)),
      columns: [
        DataColumn(label: Text('')),
        DataColumn(
            label: Text('  月', style: TextStyle(color: Color.fromARGB(255, 10, 98, 11), fontSize: 29))),
        DataColumn(
            label: Text('  火', style: TextStyle(color: Color.fromARGB(255, 10, 98, 11), fontSize: 29))),
        DataColumn(
            label: Text('  水', style: TextStyle(color: Color.fromARGB(255, 10, 98, 11), fontSize: 29))),
        DataColumn(
            label: Text('  木', style: TextStyle(color: Color.fromARGB(255, 10, 98, 11), fontSize: 29))),
        DataColumn(
            label: Text('  金', style: TextStyle(color: Color.fromARGB(255, 10, 98, 11), fontSize: 29))),
        DataColumn(
            label: Text('  土', style: TextStyle(color: Color.fromARGB(255, 10, 98, 11), fontSize: 29))),
      ],
      rows: List.generate(6, (rowIndex) {
        int startCellIndex = rowIndex * 6;
        return DataRow(
          color: MaterialStateProperty.resolveWith((states) {
            return Colors.white;
          }),
          cells: List.generate(7, (cellIndex) {
            if (cellIndex == 0) {
              return DataCell(
                InkWell(
                  onTap: () {
                    _showTimeSettingBottomSheet(context, rowIndex, startCellIndex + 1);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${rowIndex + 1}',
                            style: TextStyle(color: Color.fromARGB(255, 10, 98, 11), fontSize: 40)),
                        Text(
                          _leftColumnStartTimes[rowIndex].isNotEmpty
                              ? ' ${_leftColumnStartTimes[rowIndex]}'
                              : '開始時刻',
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          _leftColumnEndTimes[rowIndex].isNotEmpty
                              ? '~ ${_leftColumnEndTimes[rowIndex]}'
                              : '終了時刻',
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ),
              );
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

  void _showTimeSettingBottomSheet(BuildContext context, int rowIndex, int cellIndex) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height /2,   //スマホ画面の何分割か
      
          child: Column(
            children: [
          Container(child:const Text('限目',textAlign: TextAlign.left,
              style: TextStyle(fontSize: 25,color: Color.fromARGB(255, 10, 98, 11),),),),
              
             
             
              Container(child:const Text("開始時刻",style: TextStyle(fontSize: 18),)),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (DateTime dateTime) {
                    setState(() {
                      TimeOfDay time = TimeOfDay.fromDateTime(dateTime);
                      _leftColumnStartTimes[rowIndex] = '${time.hour}:${time.minute}';
                    });
                  },
                ),
              ),
              Container(child:const Text("終了時刻",style: TextStyle(fontSize: 18),)),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (DateTime dateTime) {
                    setState(() {
                      TimeOfDay time = TimeOfDay.fromDateTime(dateTime);
                      _leftColumnEndTimes[rowIndex] = '${time.hour}:${time.minute}';
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
