import 'dart:collection';

final _factories = HashMap<Type, AppInjectorFactory>();

class AppInjectorFactory<T>{
  final T Function() creator;
  T? _instance;

  AppInjectorFactory(this.creator);

  T get instance {
    _instance ??= creator();
    return _instance!;
  }

  void dispose() {
    _instance = null;
  }
}

class AppInjector{
  static final AppInjector _singleton = AppInjector._internal();
  factory AppInjector() => _singleton;
  AppInjector._internal();

  static void register<T>(AppInjectorFactory<T> factory) {
    _factories[T] = factory;
  }

  static void registerAll(Map<Type, AppInjectorFactory> factories) {
    _factories.addAll(factories);
  }

  static T get<T>() {
    final factory = _factories[T];
    if(factory == null){
      throw Exception("Factory not found for type $T");
    }
    return factory.instance;
  }

  static void dispose<T>() {
    final factory = _factories[T];
    if(factory == null){
      throw Exception("Factory not found for type $T");
    }
    try{
      factory.dispose();
    }catch(_){}
  }
}