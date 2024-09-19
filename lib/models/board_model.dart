import 'package:bsudoku/models/cell_model.dart';
import 'package:bsudoku/models/cell_position_model.dart';
import 'package:bsudoku/models/move_model.dart';

class BoardModel {
    final List<List<CellModel>> cells;
    List<CellModel> get allCells => __getAllCells();
    bool get isCompleted => cells.every((cellList) => cellList.every((element) => element.value == element.realValue));

    final List<MoveModel> movesLog;
    bool get hasLog => movesLog.isNotEmpty;
    MoveModel get lastMove => movesLog.last;

    BoardModel({ required this.cells, required this.movesLog });
    factory BoardModel.newBoard() => BoardModel(cells: [], movesLog: []);
    factory BoardModel.fromJson(Map<String, dynamic> json) {
        return BoardModel(
            cells: (json['cells'] as List<dynamic>).map((cellList){
                return (cellList as List<dynamic>).map((cell){
                    return CellModel.fromJson(cell);
                }).toList();
            }).toList(),
            movesLog: List<MoveModel>.from(json['movesLog'].map((e) => MoveModel.fromJson(e))),
        );
    }

    List<CellModel> __getAllCells() {
        List<CellModel> allCells = [];
        for (var y = 0; y < 9; y++) {
            for (var x = 0; x < 9; x++) {
                allCells.add(cells[y][x]);
            }
        }
        return allCells;
    }

    void clearCells() {
        for (var y = 0; y < 9; y++) {
            for (var x = 0; x < 9; x++) {
                cells[y][x].realValue = 0;
                cells[y][x].value = 0;
            }
        }
    }

    Set<int> getIntersectedValues(CellModel cellModel) {
        final List<CellModel> intersectedCells = allCells.where((element) =>
            element.position.x == cellModel.position.x || element.position.y == cellModel.position.y ||
            element.position.boxIndex == cellModel.position.boxIndex).toList();

        Set<int> intersectedValues = {};

        for (var element in intersectedCells) {
            if (element.hasRealValue) {
                intersectedValues.add(element.realValue);
            }
        }
        return intersectedValues;
    }

    CellModel getCellByCoordinates(int y, int x) => cells[y][x];
    CellModel getCellByPosition(CellPositionModel cellPosition) => cells[cellPosition.y][cellPosition.x];
    CellModel getCellByBoxIndex(int boxIndex, int boxCellIndex) {
        final int y = (boxIndex / 3).floor() * 3 + (boxCellIndex / 3).floor();
        final int x = boxIndex % 3 * 3 + (boxCellIndex % 3);
        return cells[y][x];
    }

    void updateCell(CellModel cellModel) {
        final int y = cellModel.position.y;
        final int x = cellModel.position.x;
        cells[y][x] = cellModel;
    }

    Map<String, dynamic> toJson() => {
        'cells': cells.map((cellList) => cellList.map((cell) => cell.toJson()).toList()).toList(),
        'movesLog': movesLog.map((e) => e.toJson()).toList(),
    };
}
