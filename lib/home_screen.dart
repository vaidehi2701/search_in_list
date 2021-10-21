import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController searchController = TextEditingController();

  static List<String> characterList = [
    "Grant Gustin",
    "Candice Patton",
    "Danielle Panabaker",
    "Carlos Valdes",
    "Tom Cavanagh",
    "Jesse L. Martin",
    "Danielle Nicolet",
    "Hartley Sawyer",
    "Keiynan Lonsdale",
    "Jessica Parker Kennedy",
    "John Wesley Shipp",
    "Kayla Compton",
    "Patrick Sabongui",
    "Rick Cosnett",
    "Wentworth Miller",
    "Brandon McKnight",
    "Stephen Amell",
    "Emily Bett Rickards"
  ];

  // Copy Main List into New List.
  List<String> newDataList = List.from(characterList);

  onSearch(String value) {
    setState(() {
      newDataList = characterList
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
           appBar: AppBar(title: const Text('Learn With Flash_coder_404')),
           body: Column(
              children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search Here...',
                      ),
                      onChanged: onSearch,
                    ),
                  ),
                  Expanded(
                    child: newDataList.length > 0?ListView(
                      padding: const EdgeInsets.all(12.0),
                      children: newDataList.map((data) {
                        return ListTile(
                          title: Text(data),
                        );
                      }).toList(),
                    ):Padding(
                      padding: const EdgeInsets.only(top:120.0),
                      child: Text("No Data Found"),
                    ),
                  )
        ],
      ),
    ));
  }
}
