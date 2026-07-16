extension Printify on String {
  void printString() {
    print(this);
  }

  bool get isValidEmail => RegExp(
    r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
  ).hasMatch(this);
}

abstract class A {
  void whatIsThis() {
    print(this);
  }
}

// class B implements A {


// }

void main() {
  // final c = A();
  final a = "hariseldev@yahoo.com";
  if (a.isValidEmail) {
    print("$a is a valid email.");
  } else {
    print("$a is not a valid email.");
  }

  // print(a);
}
