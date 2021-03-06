<?hh // strict

interface Rx {}

class A {
  <<__RxIfImplements(Rx::class)>>
  static function f(): int {
    return 1;
  }
}

class B extends A implements Rx {
}

class C extends B {
  <<__Rx>>
  public function g(): int {
    // should be OK
    return parent::f();
  }
}
