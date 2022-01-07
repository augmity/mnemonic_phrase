part of 'package:mnemonic_phrase/mnemonic_phrase.dart';

class MnemonicPhraseInput extends StatelessWidget {
  final List<String> letters =
      List<String>.generate(26, (idx) => String.fromCharCode(97 + idx));
  final ValueNotifier<List<String>> twoLetters =
      ValueNotifier<List<String>>([]);
  final ValueNotifier<List<String>> words = ValueNotifier<List<String>>([]);
  final ValueNotifier<List<String>> selectedWords =
      ValueNotifier<List<String>>([]);

  final void Function(String? duration)? onPhraseChange;
  final int maxWords;
  final ScrollController scrollController = ScrollController();

  MnemonicPhraseInput({Key? key, this.maxWords = 12, this.onPhraseChange})
      : super(key: key);

  void filterWordsByTwoLetter(String letters) {
    words.value = WORDLIST.where((item) => item.startsWith(letters)).toList();
  }

  void filterTwoLettersByLetter(String letter) {
    twoLetters.value = WORDLIST
        .where((item) => item.startsWith(letter))
        .map((item) => item.substring(0, 2))
        .toSet() // Distinct
        .toList();
  }

  void addWord(String word) {
    if (selectedWords.value.length < maxWords) {
      selectedWords.value = [...selectedWords.value, word];

      if (onPhraseChange != null) {
        var phrase = selectedWords.value.join(' ');
        if (bip39.validateMnemonic(phrase)) {
          onPhraseChange!(phrase);
        } else {
          onPhraseChange!(null);
        }
      }

      twoLetters.value = [];
      words.value = [];
      scrollController.jumpTo(0);
    }
  }

  void removeWordAt(int idx) {
    var list = [...selectedWords.value];
    list.removeAt(idx);
    selectedWords.value = list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 12),
          child: ValueListenableBuilder<List<String>>(
            valueListenable: selectedWords,
            builder: (BuildContext context, List<String> words, Widget? child) {
              if (words.isNotEmpty) {
                return Wrap(
                  spacing: 4,
                  runSpacing: 6,
                  alignment: WrapAlignment.center,
                  children: List.generate(
                    words.length,
                    (idx) {
                      return InputChip(
                        backgroundColor: Colors.black12,
                        deleteIconColor: Colors.black45,
                        label: Text(
                          '${idx + 1}. ${words[idx]}',
                        ),
                        onDeleted: () => removeWordAt(idx),
                      );
                    },
                  ),
                );
              } else {
                return Text(
                    'Please provide the $maxWords-words mnemonic phrase to import your existing identity.');
              }
            },
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 75,
                child: Scrollbar(
                  controller: scrollController,
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: letters.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        tileColor: Colors.grey.shade100,
                        title: Text(
                          letters[index],
                          textAlign: TextAlign.center,
                        ),
                        onTap: () => filterTwoLettersByLetter(letters[index]),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 75,
                child: ValueListenableBuilder<List<String>>(
                  valueListenable: twoLetters,
                  builder: (BuildContext context, List<String> items,
                      Widget? child) {
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          tileColor: Colors.grey.shade100,
                          title: Text(
                            items[index],
                            textAlign: TextAlign.center,
                          ),
                          onTap: () => filterWordsByTwoLetter(items[index]),
                        );
                      },
                    );
                  },
                ),
              ),
              Expanded(
                child: ValueListenableBuilder<List<String>>(
                  valueListenable: words,
                  builder: (BuildContext context, List<String> value,
                      Widget? child) {
                    return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            value[index],
                            textAlign: TextAlign.end,
                          ),
                          onTap: () => addWord(value[index]),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
