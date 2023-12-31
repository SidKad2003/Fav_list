import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _randomWordPairs = <WordPair>[];
  //  final List<WordPair> _airs = [
  //   WordPair('1hello', 'world'),
  //   WordPair('2flutter', 'app'),
  //   WordPair('3programming', 'language')
  // ];
  final _savedWordPairs = <WordPair>[];

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      // itemCount: 3,
      itemBuilder: (context, item) {
        if (item.isOdd) return const Divider();

        // final index = item;
        final index = item ~/ 2;

        // if (index +10000 == _randomWordPairs.length) {
        if (index >= _randomWordPairs.length) {
          _randomWordPairs.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_randomWordPairs[index]);
        // return _buildRow(_airs[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedWordPairs.contains(pair);

    return ListTile(
        title: Text(pair.asPascalCase, style: const TextStyle(fontSize: 18.0)),
        trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null),
        onTap: () {
          setState(() {
            if (alreadySaved) {
              _savedWordPairs.remove(pair);
            } else {
              _savedWordPairs.add(pair);
            }
          });
        });
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair) {
        return ListTile(
            title: Text(pair.asPascalCase, style: const TextStyle(fontSize: 16.0)));
      });

      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
          appBar: AppBar(title: const Text('Saved WordPairs')),
          body: ListView(children: divided));
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('WordPair Generator'),
          actions: <Widget>[
            IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved)
          ],
        ),
        body: _buildList());
  }
}