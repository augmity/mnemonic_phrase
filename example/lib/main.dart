import 'package:flutter/material.dart';
import 'package:mnemonic_phrase/mnemonic_phrase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mnemonic Phrase Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/changePhrase': (context) => ChangePhrasePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String phrase =
      'favorite robot woman shy observe crazy prefer script tonight eight actress kit';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mnemonic Phrase Example'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MnemonicPhrase(phrase: phrase),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Text(phrase),
            ),
            ElevatedButton(
              child: const Text('Change phrase'),
              onPressed: () =>
                  Navigator.pushNamed(context, '/changePhrase').then((value) {
                if (value != null) {
                  setState(() {
                    phrase = value as String;
                  });
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangePhrasePage extends StatelessWidget {
  ChangePhrasePage({Key? key}) : super(key: key);

  String? phrase;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Phrase'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 4),
                child: MnemonicPhraseInput(
                  // onPhraseChange is executed every single time the user changes the phrase
                  // Will return null if the phrase is incomplete/invalid, otherwise will return a phrase
                  onPhraseChange: (value) => phrase = value,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: ElevatedButton(
                  child: const Text('Update Phrase'),
                  onPressed: () {
                    if (phrase != null) {
                      Navigator.pop(context, phrase);
                    } else {
                      const snackBar = SnackBar(
                        content: Text('The phrase is invalid.'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
