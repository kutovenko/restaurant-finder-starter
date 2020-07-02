import 'package:flutter/material.dart';
import 'package:restaurant_finder/BLoC/bloc_provider.dart';
import 'package:restaurant_finder/BLoC/location_bloc.dart';
import 'package:restaurant_finder/BLoC/location_query_bloc.dart';
import 'package:restaurant_finder/DataLayer/location.dart';

class LocationScreen extends StatelessWidget{

  final bool isFullScreenDialog;

  const LocationScreen({Key key, this.isFullScreenDialog = false})
  : super(key : key);

  @override
  Widget build(BuildContext context) {
    final bloc = LocationQueryBloc();

    return BlocProvider<LocationQueryBloc>(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(title: Text('Where you want to eat?')),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter location'),
                onChanged: (query) => bloc.submitQuery(query),
              ),
            ),
            Expanded(
              child: _buildResults(bloc),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildResults(LocationQueryBloc bloc) {
    return StreamBuilder(
      stream: bloc.locationStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final results = snapshot.data;

        if (results == null){
          return Center(child: Text('Enter a Location'));
        }

        if (results.isEmpty()){
          return Center(child: Text('No results'));
        }

        return _buildSearchResults(results);
      },

    );
  }

  Widget _buildSearchResults(List<Location> results) {
    return ListView.separated(
        itemBuilder: (context, index){
          final location = results[index];
          return ListTile(
            title: Text(location.title),
            onTap: () {
              final locationBloc = BlocProvider.of<LocationBloc>(context);
              locationBloc.selectLocation(location);

              if (isFullScreenDialog){
                Navigator.of(context).pop();
              }
            },
          );
        },
        separatorBuilder: (BuildContext conext, int index) => Divider(),
        itemCount: results.length,
    );
  }
}

