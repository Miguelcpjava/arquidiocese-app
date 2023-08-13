import 'package:intl/intl.dart';

class DataTimeFormarter {
  String getTransformerData(String data) {
    var typeData = DateTime.parse(data);
    return DateFormat("dd/MM/yyyy").format(typeData);
  }

  DateTime setStringDataParaDataTime(String data) {
    var typeData = DateTime.parse(data);
    return typeData;
  }

  String getTransformadorStringParaData(DateTime data) {
    return DateFormat("dd/MM/yyyy").format(data);
  }
}
