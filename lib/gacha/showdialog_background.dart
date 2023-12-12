import 'package:flutter/material.dart';

 void showDialogBackground(BuildContext context, String selectedElement) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
              color: Color.fromARGB(255, 143, 98, 82),
              width: 6.0,
            ),
          ),
          content: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                const Text(
                  '背景画像ゲット！！',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Image.asset(
                  'assets/backgrounds/$selectedElement.png',
                  width: 140,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                const Text(
                  'この背景に変更しますか?',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 66, 183, 70),
                        foregroundColor: Colors.red,
                      ),
                      child: const Text(
                        'これに変更する',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 170, 177, 171),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        '       閉じる       ',
                        style: TextStyle(color: Colors.white),
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
