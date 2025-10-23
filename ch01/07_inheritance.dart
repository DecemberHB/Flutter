/*
  날짜 : 2025/10/23
  이름 : 박효빈
  내용 : Dart 상속
*/
// 부모 클래스
class Animal {
  String _name;
  Animal(this._name);

  void speak(){
    print('speak $_name');
  }

  void move(){
    print('move $_name');
  }
}

class Dog extends Animal {
  String _breed;
  Dog(String name, this._breed) : super(name); // 부모 생성자 호출

  @override
  void speak(){
    print('$_name($_breed) 멍멍 !');

  }

  void walk(){
    print('$_name($_breed) 산책 중 ...');

  }

}

class Cat extends Animal {
  String _breed;

  Cat(String name, this._breed) : super(name); // 부모 생성자 호출

  @override
  void speak() {
    print('$_name($_breed) 야옹 !');
  }

  void walk() {
    print('$_name($_breed) 캣타워 오르는 중 ...');
  }
}
void main(){
  // Animal 생성
  Animal animal = Animal('동물');
  animal.speak();
  animal.move();

  // Dog 생성
  Dog myDog = Dog('순돌이', '푸들');
  myDog.speak();
  myDog.move();

  // Cat 생성
  Cat myCat = Cat('냥이', '샴');
  myCat.speak();
  myCat.move();

  // 다형성
  Animal a1 = Dog('바둑이', '진돗개');
  Animal a2 = Cat('냐옹이', '로켓단');

  a1.speak();
  a2.speak();

  if(a1 is Dog){
    a1.walk();
  }

  if(a2 is Cat){
    a2.walk();
  }

}