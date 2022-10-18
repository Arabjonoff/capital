import 'package:capital/src/database_helper/database_helper.dart';
import 'package:capital/src/provider/main_provider.dart';
import 'package:capital/src/utils/constants.dart';
import 'package:capital/src/widgets/word_item/word_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class WordListWidget extends StatefulWidget {
  const WordListWidget({Key? key}) : super(key: key);

  @override
  State<WordListWidget> createState() => _WordListWidgetState();
}

class _WordListWidgetState extends State<WordListWidget> {
  @override
  void initState() {
    super.initState();
    loadDB();
  }

  Future<void> loadDB() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoaded = prefs.getBool(Constants.IS_DATABASE_INIT) ?? false;

    if (!isLoaded) {
      await DatabaseHelper.instance.loadDB(context);
    }
    updateQuery();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .9,
      child: Consumer<MainProvider>(builder: (context, data, child) {
        return Scrollbar(
          interactive: true,
          thickness: 12.0,
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 10),
            itemBuilder: (context, index) {
              return WordItemWidget( world: data.words[index],);
            },
            itemCount: data.words.length,
          ),
        );
      }),
    );
  }

  void updateQuery({String? word, bool? isCity}) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    mainProvider.initList(word: word, isCity: isCity);
  }
}