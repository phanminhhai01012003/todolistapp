import 'dart:math';

String generateRandomString(int length){
  final rand = Random();
  const availableChars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  return String.fromCharCodes(
    Iterable.generate(
      length, 
      (_) => availableChars.codeUnitAt(rand.nextInt(availableChars.length))
    )
  );
}

int generateRandomInt(int max) {
  final rand = Random();
  return rand.nextInt(max);
}