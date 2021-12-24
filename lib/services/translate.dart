import "package:translator/translator.dart";

class TranslateService {
  GoogleTranslator translator = GoogleTranslator();

  Future translateSentense(String str) async {
    try {
      var s = await translator.translate(str, from: 'si', to: 'en');
      return s.toString();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
