import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:excel/excel.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _labelText = "Please Select Excel File";
  bool _pickerVsb = true;
  bool _getListBtnVsb = false;
  bool _loadingVsb = false;
  bool _listVsb = false;
  late String excelPath;
  Map<int, List<dynamic>> excelMap = Map<int, List<dynamic>>();

  Future _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls', 'csv'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      excelPath = file.path;
      debugPrint(file.name);
      debugPrint(file.bytes.toString());
      debugPrint(file.size.toString());
      debugPrint(file.extension);
      debugPrint(file.path);
      setState(() {
        _labelText = file.name;
        _getListBtnVsb = true;
      });
    } else {
      //Cancelled Picker
      setState(() {
        _labelText = "Please Select Excel File";
        _getListBtnVsb = false;
      });
    }
  }

  Future _readExcel() async {
    var file = excelPath;
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    int j = 0;
    for (var table in excel.tables.keys) {
      debugPrint(table);
      debugPrint(excel.tables[table]!.maxCols.toString());
      debugPrint(excel.tables[table]!.maxRows.toString());
      for (var row in excel.tables[table]!.rows) {
        setState(() {
          excelMap[j++] = row;
          _loadingVsb = false;
          _listVsb = true;
          _getListBtnVsb = false;
          _pickerVsb = false;
        });

        debugPrint(excelMap[0]?[0]);
        debugPrint(excelMap.length.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('HomePage'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: _pickerVsb,
              child: ElevatedButton.icon(
                onPressed: () {
                  _openFilePicker();
                },
                icon: const Icon(Icons.list_alt),
                label: Text(_labelText),
                style: ButtonStyle(
                  fixedSize:
                      MaterialStateProperty.all<Size>(const Size(280, 50)),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(10)),
                  elevation: MaterialStateProperty.all<double>(5.0),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xffD52941),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ),
            const Text('\n'),
            Visibility(
              visible: _getListBtnVsb,
              child: ElevatedButton.icon(
                onPressed: () {
                  _readExcel();
                },
                icon: const Icon(Icons.list_alt),
                label: const Text('Get ListView From Excel'),
                style: ButtonStyle(
                  fixedSize:
                      MaterialStateProperty.all<Size>(const Size(280, 50)),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(10)),
                  elevation: MaterialStateProperty.all<double>(5.0),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xff388697),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _listVsb,
              child: Expanded(
                child: excelMap.isNotEmpty
                    ? ListView.builder(
                        itemCount: excelMap.length,
                        itemBuilder: (context, index) => Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          key: ValueKey(excelMap[index]?[0]),
                          color: const Color(0xff545d6e),
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            title: Text(excelMap[index]?[3]),
                          ),
                        ),
                      )
                    : Visibility(
                        visible: _loadingVsb,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
