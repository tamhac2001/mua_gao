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
    TypeOfRice(id: 'T1', title: 'Gạo mềm'),
  ];

  List<TypeOfRice> get types {
    return [..._types];
  }

  TypeOfRice findById(String id){
    return _types.firstWhere((type) => type.id==id);
  }

  void increaseNumberOfRice(String id){
    findById(id).increaseNumberOfRice();

  }

  int numberOfRice(String id){
    return findById(id).numberOfRice;
  }

  String getTitle(String id){
    return findById(id).title;
  }



}

