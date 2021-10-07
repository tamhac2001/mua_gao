import 'package:flutter/material.dart';

class TypeOfRice {
  final String id;
  final String title;
  int numberOfRice = 0;

  TypeOfRice({
    required this.id,
    required this.title,
  });

  void increaseNumberOfRice(){
    numberOfRice++;
  }
}

class TypesOfRice {
  static final TypesOfRice _instance = TypesOfRice._internal();
  factory TypesOfRice() => _instance;
  TypesOfRice._internal();

  List<TypeOfRice> _types = [
    TypeOfRice(id: 'T1', title: 'Gao mem'),
  ];

  List<TypeOfRice> get types {
    return [..._types];
  }

  void increaseNumberOfRice(String id){
    _types.firstWhere((type) => type.id==id).increaseNumberOfRice();

  }

  int numberOfRice(String id){
    return _types.firstWhere((type) => type.id==id).numberOfRice;
  }

}

