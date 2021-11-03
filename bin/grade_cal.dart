import 'dart:io';

class GradeCal {
  var _file = File('data//standardDeviationTable.txt');
  
  List<List<String>>? table = [];

  cal(int score, double average, double standardDeviation) async {
    await load();

    num z = (score - average) / standardDeviation;
    
    var str_z = '$z';

    var z1 = double.parse((z < 0) ? str_z.substring(0,4) : str_z.substring(0,3));
    var z2 = double.parse(str_z.substring(str_z.length - 1));

    var index1 = int.parse('${(z1 + 4) * 10}'.split('.').first);
    var index2 = int.parse('${z2}'.split('.').first);

    var percentage = 100 - (double.parse(table![index1][index2]) * 100);

    return double.parse(percentage.toStringAsFixed(3));
  }

  load() async {
    List<String> line = [];

    await _file.readAsLines()
      .then(
        (value) => {
          for (var i in value) {
            if (i is String) {
              line = i.split('\t')
            },

            table!.add(line)
          }
        }
      );
  }
}
