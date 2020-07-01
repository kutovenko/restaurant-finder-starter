import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Where you want to eat?')),
      body: Column(
        children: <Widget>[
          Padding(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: 'Enter location'),
              onChanged: (query) { },
            ),
          ),
          Expanded(
            child: _buildResults(),
          )
        ],
      ),
    );
  }

  Widget _buildResults() {
    return Center(
      child: Text('Enter a location')
    );
  }
}
