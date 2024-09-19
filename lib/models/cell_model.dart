import 'dart:convert';

import 'package:bsudoku/models/cell_position_model.dart';

class CellModel {
    int value, realValue;
    bool get hasValue => value != 0;
    bool get hasRealValue => realValue != 0;
    bool get isValueCorrect => hasValue && value == realValue;

    bool isGivenNumber, isHighlighted;
    bool scored = false;

    List<int> notes;
    bool get hasNotes => notes.isNotEmpty;
    List<String> get stringNotes => notes.map((note)=> note.toString()).toList();

    final CellPositionModel position;

    CellModel({ this.value = 0, required this.realValue, required this.position, this.isGivenNumber = false, this.isHighlighted = false,  required this.notes,});
    factory CellModel.fromJson(Map<String, dynamic> json) {
        return CellModel(
            value: json['value'], realValue: json['realValue'],
            isGivenNumber: json['isGivenNumber'], isHighlighted: json['isHighlighted'],
            position: CellPositionModel.fromJson(json['position']),
            notes: List<int>.from(json['notes']));
    }

    bool hasIntersectionWith(CellPositionModel cellPosition) => position.x == cellPosition.x || position.y == cellPosition.y || position.boxIndex == cellPosition.boxIndex;
    bool notesContains(int number) => notes.contains(number);

    String print() => isGivenNumber ? realValue.toString() : hasValue ? value.toString() : ' ';

    Map<String, dynamic> toJson() => {
        'value': value, 'realValue': realValue,
        'isGivenNumber': isGivenNumber, 'isHighlighted': isHighlighted,
        'notes': notes, 'position': position.toJson(),
    };
}
