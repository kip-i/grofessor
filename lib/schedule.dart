import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:grofessor/_state.dart';
import 'package:provider/provider.dart';

class Schedule extends StatelessWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.0,
          centerTitle: false,
          backgroundColor: Colors.white.withOpacity(0.0),
          elevation: 0.0,
          title: const Padding(padding: EdgeInsets.only(top: 20.0),
          child: Text(
            '時間割表',
            style: TextStyle(
              color: Color.fromARGB(255, 10, 98, 11),
              fontStyle: FontStyle.italic,
              fontSize: 33.0,
            ),
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

  @override
  Widget build(BuildContext context) {
    final classProvider = Provider.of<ClassProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final now = DateTime.now();
    return DataTable(
      dataRowMaxHeight: 190.0,
      decoration: const BoxDecoration(color: Color.fromARGB(255, 195, 199, 195)),
      columns: const [
        DataColumn(label: Text('')),
        DataColumn(
            label: Text(' 月',
                style: TextStyle(
                    color: Color.fromARGB(255, 10, 98, 11), fontSize: 29))),
        DataColumn(
            label: Text(' 火',
                style: TextStyle(
                    color: Color.fromARGB(255, 10, 98, 11), fontSize: 29))),
        DataColumn(
            label: Text('  水',
                style: TextStyle(
                    color: Color.fromARGB(255, 10, 98, 11), fontSize: 29))),
        DataColumn(
            label: Text(' 木',
                style: TextStyle(
                    color: Color.fromARGB(255, 10, 98, 11), fontSize: 29))),
        DataColumn(
            label: Text(' 金',
                style: TextStyle(
                    color: Color.fromARGB(255, 10, 98, 11), fontSize: 29))),
        DataColumn(
            label: Text(' 土',
                style: TextStyle(
                    color: Color.fromARGB(255, 10, 98, 11), fontSize: 29))),
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
                    _showTimeSettingBottomSheet(context, rowIndex,
                        startCellIndex + 1, classProvider, userProvider, now);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${rowIndex + 1}',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 10, 98, 11),
                                fontSize: 40)),
                        Text(
                          classProvider.classTimeList != []
                              ? ' ${classProvider.classTimeList[rowIndex][0].toString().padLeft(2, "0")}時${classProvider.classTimeList[rowIndex][1].toString().padLeft(2, "0")}分'
                              : '開始時刻',
                          style: const TextStyle(fontSize: 25),
                        ),
                        Text(
                          classProvider.classTimeList != []
                              ? '~ ${classProvider.classTimeList[rowIndex][2].toString().padLeft(2, "0")}時${classProvider.classTimeList[rowIndex][3].toString().padLeft(2, "0")}分'
                              : '終了時刻',
                          style: const TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return DataCell(
                Transform.scale(
                  scale: 4.0,
                  child: Checkbox(
                    fillColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
                    checkColor: Colors.green,
                    value: classProvider.classFlagList[cellIndex - 1][rowIndex],
                    onChanged: (bool? value) {
                      classProvider.setClassFlagList(
                          userProvider.userId, cellIndex - 1, rowIndex);
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

  void _showTimeSettingBottomSheet(
    BuildContext context,
    int rowIndex,
    int cellIndex,
    ClassProvider classProvider,
    UserProvider userProvider,
    DateTime now) {
      showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height: MediaQuery.of(context).copyWith().size.height / 2,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 2 - 30),
                    child: Text(
                      '${rowIndex + 1}限目',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 10, 98, 11),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 25,
                      color: Colors.black,
                    )
                  ),
                ],
              ),
              const Text(
                  "開始時刻",
                style: TextStyle(fontSize: 18),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: DateTime(
                    now.year,
                    now.month,
                    now.day,
                    classProvider.classTimeList[rowIndex][0],
                    classProvider.classTimeList[rowIndex][1]),
                    onDateTimeChanged: (DateTime dateTime) {
                      TimeOfDay time = TimeOfDay.fromDateTime(dateTime);
                      classProvider.setClassStartTimeList(userProvider.userId,
                        [time.hour, time.minute], rowIndex);
                    },
                  use24hFormat: true, // Set this to true for 24-hour format
                ),
              ),
              const Text(
                "終了時刻",
                style: TextStyle(fontSize: 18),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: DateTime(
                    now.year,
                    now.month,
                    now.day,
                    classProvider.classTimeList[rowIndex][2],
                    classProvider.classTimeList[rowIndex][3]),
                  onDateTimeChanged: (DateTime dateTime) {
                    TimeOfDay time = TimeOfDay.fromDateTime(dateTime);
                    classProvider.setClassFinishTimeList(userProvider.userId,
                        [time.hour, time.minute], rowIndex);
                  },
                  use24hFormat: true, // Set this to true for 24-hour format
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
