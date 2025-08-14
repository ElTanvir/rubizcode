class AppAssets {
  static Images image = Images();
  static Svgs svgs = Svgs();
  static Rives rives = Rives();
  static Lotties lotties = Lotties();
}

class Images {
  String image = 'assets/images/image.png';
}

class Svgs {
  String medal(int number) => 'assets/svgs/medal$number.svg';
}

class Rives {
  final String rives = 'assets/rives/rives.riv';
}

class Lotties {
  final String failure = 'assets/lotties/failure.json';
  final String student = 'assets/lotties/student.json';
  final String success = 'assets/lotties/success.json';
}
