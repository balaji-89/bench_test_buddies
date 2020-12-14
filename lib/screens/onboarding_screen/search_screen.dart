import 'dart:ui';

import 'package:bench_test_buddies/provider/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends SearchDelegate<String> {

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      Container(
        height: MediaQuery.of(context).size.height*0.08,
        width: MediaQuery.of(context).size.width*0.7,
        color:Theme.of(context).accentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.search,color: Colors.grey,),
                  Text('Search',style: TextStyle(color:Colors.grey,fontSize: 10),)
                ],
              ),
            ),
            IconButton(icon: Icon(Icons.clear,color: Colors.grey,size: 15,), onPressed: (){}),

          ],
        ),
      ),
    ];

  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back,color:Colors.black,size: 15,),
      onPressed: (){},
    );

  }

  // @override
  // ThemeData appBarTheme(BuildContext context) {
  //   return ThemeData(
  //     backgroundColor: Theme.of(context).accentColor,
  //
  //
  //   );
  // }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List country=Provider.of<CountryProvider>(context).countryNames;
    return ListView.builder(itemCount: country.length,itemBuilder:(context,index)=>Container(
      height: MediaQuery.of(context).size.height*0.07,
      alignment: Alignment.center,

      child: Text(country[index],style: TextStyle(
        color:Colors.black,

      ),),

    ));
  }

  }

