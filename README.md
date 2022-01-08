# Mnemonic Phrase plugins

[![pub package](https://img.shields.io/pub/v/mnemonic_phrase.svg)](https://pub.dev/packages/mnemonic_phrase)

A flutter package that displays a mnemonic phrase / allows users to provide a mnemonic phrase.

<img src="https://github.com/augmity/mnemonic_phrase/raw/master/doc/mnemonic_phrase.gif" alt="demo">

## Example

There are two separate plugins: one for display and one for input.
See the full example app in `/example' folder of the repository.

### Display

``` dart
  MnemonicPhrase(phrase: 'favorite robot woman shy observe crazy prefer script tonight eight actress kit')
```

### Input

``` dart
  MnemonicPhraseInput(
    // onPhraseChange is executed every single time the user changes the phrase
    // Will return null if the phrase is incomplete/invalid, otherwise will return a phrase
    onPhraseChange: (value) {
      print(value);
    },
  ),
```
