extension StringExtension on String{
  String get capitalizeEveryFirstLetter{
    String result = "";
    if(split(" ").isNotEmpty){
      split(" ").forEach((phrase) {
        result += "${phrase[0].toUpperCase()+phrase.substring(1).toLowerCase()} ";
      });
    }else{
      result += this[0].toUpperCase()+substring(1).toLowerCase();
    }

    return result;
  }
}