import 'dart:ui';

import 'package:bench_test_buddies/provider/country_provider.dart';
import 'package:bench_test_buddies/provider/user_data_token.dart';
import 'package:bench_test_service/service/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.grey,
            size: 20,
          ),
          onPressed: () {
            query = '';
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.black,
        size: 20,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var countryNames =
        Provider.of<CountryProvider>(context, listen: false).getCountryNames;
    final List country = query.isEmpty
        ? countryNames
        : countryNames.where((element) => element.startsWith(query)).toList();
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(
              color: Colors.grey[600],
              indent: MediaQuery.of(context).size.width * 0.04,
              endIndent: MediaQuery.of(context).size.width * 0.04,
            ),
        padding: EdgeInsets.only(top:10),
        itemCount: country.length,
        itemBuilder: (context, index) => SizedBox(
              height: MediaQuery.of(context).size.height * 0.055,
              child: InkWell(
                onTap: () {
                  Provider.of<CountryProvider>(context, listen: false)
                      .initializeSelectedCountry(country[index]);
                  close(context, null);
                },
                child: ListTile(
                  leading: query.isNotEmpty
                      ? Icon(
                          Icons.search,
                          color: Colors.grey,
                        )
                      : null,
                  title: RichText(
                      text: TextSpan(
                    text: country[index].substring(0, query.length),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF232323),
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                          text: country[index].substring(query.length),
                          style: TextStyle(
                            color: Color(0xFF232323),
                            fontSize: 15,
                          )),
                    ],
                  )),
                ),
              ),
            ));
  }
}
