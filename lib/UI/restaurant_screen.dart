import 'package:flutter/material.dart';
import 'package:restaurant_finder/BLoC/bloc_provider.dart';
import 'package:restaurant_finder/BLoC/restaurant_bloc.dart';
import 'package:restaurant_finder/DataLayer/location.dart';
import 'package:restaurant_finder/DataLayer/restaurant.dart';
import 'package:restaurant_finder/UI/image_container.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key key, @required this.location}) : super(key : key);

  final Location location;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location.title),
      ),
      body: _buildSearch(context),
    );
  }

  _buildSearch(BuildContext context) {
    final bloc = RestaurantBloc(location);

    return BlocProvider<RestaurantBloc>(
      bloc: bloc,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'What do you want to eat?'
              ),
              onChanged: (query) => bloc.submitQuery(query),
            ),
          ),
          Expanded(
            child: _buildStreamBuilder(bloc),
          )
        ],
      ),
    );
  }

  _buildStreamBuilder(RestaurantBloc bloc) {
    return StreamBuilder(
      stream: bloc.stream,
      builder: (context, snapshot){
        final results = snapshot.data;

        if (results == null) {
          return Center(
              child: Text('No results')
          );
        }

        return _buildSearchResults(results);
      },
    );
  }

}

Widget _buildSearchResults(List<Restaurant> results) {
  return ListView.separated(itemBuilder: (context, index){
    final restaurant = results[index];
    return RestaurantTile(restaurant: restaurant);
  },
      separatorBuilder: (context, index) => Divider(),
      itemCount: results.length);
}

class RestaurantTile extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantTile({Key key, @required this.restaurant}): super (key : key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ImageContainer(url: restaurant.thumbUrl, width: 50, height: 50),
      title: Text(restaurant.name),
      trailing: Icon(Icons.keyboard_arrow_right),
    );
  }
}

