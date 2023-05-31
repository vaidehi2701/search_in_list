import 'package:flutter/material.dart';
import 'package:search_in_list/data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController searchController = TextEditingController();

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
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        title: const Text('DevDiariesWithVee'),
        backgroundColor: Colors.purple[300],
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: searchController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.0),
                  ),
                  hintText: 'Search Here...',
                  hintStyle: TextStyle(color: Colors.white)),
              onChanged: onSearch,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: newDataList.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView(
                      children: List.generate(
                        newDataList.length,
                        (i) => AnimatedListItem(index: i, data: newDataList[i]),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 120.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.face_retouching_natural_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          "  No Data Found",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }
}

class AnimatedListItem extends StatefulWidget {
  final int index;
  final String data;
  const AnimatedListItem({Key? key, required this.index, required this.data})
      : super(key: key);

  @override
  State<AnimatedListItem> createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem> {
  bool _animate = false;
  static bool _isStart = true;

  @override
  void initState() {
    super.initState();
    if (_isStart) {
      Future.delayed(Duration(milliseconds: widget.index * 300), () {
        setState(() {
          _animate = true;
          _isStart = false;
        });
      });
    } else {
      _animate = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1000),
      opacity: _animate ? 1 : 0,
      curve: Curves.easeInOutQuart,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 1000),
        padding: _animate
            ? const EdgeInsets.all(4.0)
            : const EdgeInsets.only(top: 10),
        child: Container(
          constraints: const BoxConstraints.expand(height: 50),
          child: Card(
            color: Colors.grey[500],
            child: Center(
              child: Text(
                widget.data,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
