abstract class AppEvent {
  Object? arguments;
  AppEvent({this.arguments});
}

class Click extends AppEvent {
  Click({super.arguments});
}

class Resend extends AppEvent {
  Resend({super.arguments});
}

class Remember extends AppEvent {
  Remember({super.arguments});
}

class Get extends AppEvent {
  Get({super.arguments});
}

class Read extends AppEvent {
  Read({super.arguments});
}

class Send extends AppEvent {
  Send({super.arguments});
}

class Hide extends AppEvent {
  Hide({super.arguments});
}

class Show extends AppEvent {
  Show({super.arguments});
}

class Add extends AppEvent {
  Add({super.arguments});
}

class Init extends AppEvent {
  Init({super.arguments});
}

class Delete extends AppEvent {
  Delete({super.arguments});
}

class Clear extends AppEvent {
  Clear({super.arguments});
}

class Update extends AppEvent {
  Update({super.arguments});
}

class Turn extends AppEvent {
  Turn({super.arguments});
}

class Search extends AppEvent {
  Search({super.arguments});
}

class Open extends AppEvent {
  Open({super.arguments});
}
