import 'package:flutter/cupertino.dart';

class RickMortyProvider extends ChangeNotifier {
  int currentIndex = 0;
  bool checked = true;
  bool isGridview = false;

  void update() {
    notifyListeners();
  }

  void togridview() {
    isGridview = !isGridview;
    notifyListeners();
  }

  void currentindex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Color? colorStatus(String statusColor) {
    switch (statusColor) {
      case 'Alive':
        return const Color(0xff43D049);
      case 'Dead':
        return const Color(0xffEB5757);
      case 'Unknown':
        return const Color(0xff22A2BD);
    }
    return const Color(0xff22A2BD);
  }
}
