part of 'package:mnemonic_phrase/mnemonic_phrase.dart';

class MnemonicPhrase extends StatelessWidget {
  const MnemonicPhrase({Key? key, required this.phrase})
      : super(key: key);
  final String phrase;
  List<String> get words => phrase.split(' ');

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      alignment: WrapAlignment.center,
      children: List.generate(
        words.length,
        (idx) {
          return FilterChip(
            backgroundColor: Colors.black12,
            label: Text(
              '${idx + 1}. ${words[idx]}',
            ),
            onSelected: (bool value) {},
          );
        },
      ),
    );
  }
}
