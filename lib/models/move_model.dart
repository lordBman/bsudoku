import 'package:bsudoku/models/cell_position_model.dart';

class MoveModel {
    final CellPositionModel cellPosition;
    final int value, oldValue;
    final List<int> notes, oldNotes;

    MoveModel({ required this.cellPosition, required this.value, required this.oldValue, required this.notes, required this.oldNotes });
    factory MoveModel.fromJson(Map<String, dynamic> json) {
        return MoveModel(
            cellPosition: CellPositionModel.fromJson(json['cellPosition']),
            value: json['value'], oldValue: json['oldValue'],
            notes: List<int>.from(json['notes']),
            oldNotes: List<int>.from(json['oldNotes']),
        );
    }

    String print() => 'value: $value, oldValue: $oldValue, notes: $notes, oldNotes: $oldNotes';

    Map<String, dynamic> toJson() => {
      'cellPosition': cellPosition.toJson(),
      'value': value, 'oldValue': oldValue,
      'notes': notes, 'oldNotes': oldNotes,
    };
}
