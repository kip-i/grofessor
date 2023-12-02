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



class MyDataTable extends StatefulWidget {    //MyDataTableクラスを作成
  @override
  _MyDataTableState createState() => _MyDataTableState(); //ジャンプする
}

class _MyDataTableState extends State<MyDataTable> {   //_MyDataTableStateクラスを作成
  // チェックボックスの状態を管理するためのリスト
  List<bool> _isSelected = List.generate(36, (index) => false);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      dataRowMaxHeight:170.0,
      decoration: BoxDecoration(color: Color.fromARGB(255, 195, 199, 195),),
      columns: [
        DataColumn(label: Text('')),
        DataColumn(label: Text('  月',style:TextStyle(color:Color.fromARGB(255, 10, 98, 11),fontSize:27),)),
        DataColumn(label: Text('  火',style:TextStyle(color:Color.fromARGB(255, 10, 98, 11),fontSize:27),)),
        DataColumn(label: Text('  水',style:TextStyle(color:Color.fromARGB(255, 10, 98, 11),fontSize:27),)),
        DataColumn(label: Text('  木',style:TextStyle(color:Color.fromARGB(255, 10, 98, 11),fontSize:27),)),
        DataColumn(label: Text('  金',style:TextStyle(color:Color.fromARGB(255, 10, 98, 11),fontSize:27),)),
        DataColumn(label: Text('  土',style:TextStyle(color:Color.fromARGB(255, 10, 98, 11),fontSize:27),)),
      ],
      rows: [
        DataRow(color: MaterialStateProperty.resolveWith((states) {
          return Colors.white;}),        //一限目
          cells: [
            
            DataCell(Text('1',style:TextStyle(color:Color.fromARGB(255, 10, 98, 11),fontSize:28),)),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[0],onChanged: (bool? value) {
                  setState(() {_isSelected[0] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[6],onChanged: (bool? value) {
                  setState(() {_isSelected[6] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[12],onChanged: (bool? value) {
                  setState(() {_isSelected[12] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[18],onChanged: (bool? value) {
                  setState(() {_isSelected[18] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[24],onChanged: (bool? value) {
                  setState(() {_isSelected[24] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[30],onChanged: (bool? value) {
                  setState(() {_isSelected[30] = value!;});}),),),
               ],),
        
        DataRow(color: MaterialStateProperty.resolveWith((states) {
          return Colors.white;}),        //二限目
          cells: [
            
            DataCell(Text('2',style:TextStyle(color:Color.fromARGB(255, 10, 98, 11),fontSize:28),)),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[1],onChanged: (bool? value) {
                  setState(() {_isSelected[1] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[7],onChanged: (bool? value) {
                  setState(() {_isSelected[7] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[13],onChanged: (bool? value) {
                  setState(() {_isSelected[13] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[19],onChanged: (bool? value) {
                  setState(() {_isSelected[19] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[25],onChanged: (bool? value) {
                  setState(() {_isSelected[25] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[31],onChanged: (bool? value) {
                  setState(() {_isSelected[31] = value!;});}),),),
                  ],),
        
        DataRow(color: MaterialStateProperty.resolveWith((states) {
          return Colors.white;}),       
          cells: [
            
            DataCell(Text('3',style:TextStyle(color:Color.fromARGB(255, 10, 98, 11),fontSize:28),)),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[2],onChanged: (bool? value) {
                  setState(() {_isSelected[2] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[8],onChanged: (bool? value) {
                  setState(() {_isSelected[8] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[14],onChanged: (bool? value) {
                  setState(() {_isSelected[14] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[20],onChanged: (bool? value) {
                  setState(() {_isSelected[20] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[26],onChanged: (bool? value) {
                  setState(() {_isSelected[26] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[32],onChanged: (bool? value) {
                  setState(() {_isSelected[32] = value!;});}),),),
                  ],),

        DataRow(color: MaterialStateProperty.resolveWith((states) {
          return Colors.white;}),       
          cells: [
            
            DataCell(Text('4',style:TextStyle(color:Color.fromARGB(255, 10, 98, 11),fontSize:28),)),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[3],onChanged: (bool? value) {
                  setState(() {_isSelected[3] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[9],onChanged: (bool? value) {
                  setState(() {_isSelected[9] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[15],onChanged: (bool? value) {
                  setState(() {_isSelected[15] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[21],onChanged: (bool? value) {
                  setState(() {_isSelected[21] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[27],onChanged: (bool? value) {
                  setState(() {_isSelected[27] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[33],onChanged: (bool? value) {
                  setState(() {_isSelected[33] = value!;});}),),),
                  ],),
        
        DataRow(color: MaterialStateProperty.resolveWith((states) {
          return Colors.white;}),       
          cells: [
            
            DataCell(Text('5',style:TextStyle(color:Color.fromARGB(255, 10, 98, 11),fontSize:28),)),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[4],onChanged: (bool? value) {
                  setState(() {_isSelected[4] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[10],onChanged: (bool? value) {
                  setState(() {_isSelected[10] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[16],onChanged: (bool? value) {
                  setState(() {_isSelected[16] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[22],onChanged: (bool? value) {
                  setState(() {_isSelected[22] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[28],onChanged: (bool? value) {
                  setState(() {_isSelected[28] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[34],onChanged: (bool? value) {
                  setState(() {_isSelected[34] = value!;});}),),),
                  ],),
        
        DataRow(color: MaterialStateProperty.resolveWith((states) {
          return Colors.white;}),       
          cells: [
            
            DataCell(Text('6',style:TextStyle(color:Color.fromARGB(255, 10, 98, 11),fontSize:28),)),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[5],onChanged: (bool? value) {
                  setState(() {_isSelected[5] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[11],onChanged: (bool? value) {
                  setState(() {_isSelected[11] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[17],onChanged: (bool? value) {
                  setState(() {_isSelected[17] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[23],onChanged: (bool? value) {
                  setState(() {_isSelected[23] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[29],onChanged: (bool? value) {
                  setState(() {_isSelected[29] = value!;});}),),),
            DataCell(Transform.scale(scale:2.0,child:Checkbox(value: _isSelected[35],onChanged: (bool? value) {
                  setState(() {_isSelected[35] = value!;});}),),),
                  ],),
      ],
    );
  }
}  //_MyDataTableStateクラスの終わり
