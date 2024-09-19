class CellPositionModel{
    final int y, x;
    int get boxIndex => 3 * (y / 3).floor() + (x / 3).floor();

    CellPositionModel({required this.y, required this.x });
    factory CellPositionModel.fromJson(Map<String, dynamic> json) {
        return CellPositionModel( x: json['x'], y: json['y'] );
    }

    String print() => 'y: $y, x: $x,   box: $boxIndex\n';

    Map<String, dynamic> toJson() => { 'y': y, 'x': x };
}