import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

 void showDialog_Skin(BuildContext context, selectedElement) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: const Color.fromARGB(255, 143, 98, 82),
              width: 6.0,
            ),
          ),
          content: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 5),
                Text(
                  'スキンをゲット！！',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Cube(
                    onSceneCreated: (Scene scene) {
                      scene.world.add(Object(
                        fileName: 'assets/models/' +
                            selectedElement +
                            '.obj',
                        scale: Vector3(15.0, 15.0, 15.0),
                        rotation: Vector3(270.0, 180.0, 0.0),
                        position: Vector3(-0.9, -4.0, 0.0),
                      ));
                    },
                  )
                ),
                // Text(selectedElement),
                // SizedBox(height: 20),
                // Text(
                //   'このスキンに変更しますか?',
                //   style: TextStyle(
                //     decoration: TextDecoration.underline,
                //   ),
                // ),
                SizedBox(height: 10),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'これに変更する',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 66, 183, 70),
                        onPrimary: Colors.red,
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        '       閉じる       ',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 170, 177, 171),
                        onPrimary: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
}
