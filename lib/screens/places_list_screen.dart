import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:places_app/providers/greate_places.dart';
import 'package:places_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus lugares'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
          ? Center(child: CircularProgressIndicator())
          : Consumer<GreatPlaces>(
          child: Center(
            child: Text('Nenhum local cadastrado!'),
          ),
          builder: (ctx, greatPlaces, ch) => greatPlaces.itemsCount == 0
              ? ch
              : ListView.builder(
                  itemCount: greatPlaces.itemsCount,
                  itemBuilder: (ctx, i) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          FileImage(greatPlaces.itemByIndex(i).image),
                    ),
                    title: Text(greatPlaces.itemByIndex(i).title),
                    subtitle: Text(
                              greatPlaces.itemByIndex(i).location!.address!),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.PLACE_DETAIL,
                        arguments: greatPlaces.itemByIndex(i),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
