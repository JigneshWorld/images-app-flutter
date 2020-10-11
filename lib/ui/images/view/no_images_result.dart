import 'package:flutter/material.dart';

class NoImagesResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'No Images Found',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 48,
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('CLOSE'),
          ),
        ],
      ),
    );
  }
}
