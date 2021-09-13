import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _labelText = "Please Select Excel File";
  bool _getListBtnVsb = false;

  Future _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls', 'csv'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;

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
            ElevatedButton.icon(
              onPressed: () {
                _openFilePicker();
              },
              icon: const Icon(Icons.list_alt),
              label: Text(_labelText),
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(const Size(280, 50)),
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
            const Text('\n'),
            Visibility(
              visible: _getListBtnVsb,
              child: ElevatedButton.icon(
                onPressed: () {
                  //Add Excel Read Function Here
                },
                icon: const Icon(Icons.list_alt),
                label: Text('Get ListView From Excel'),
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
          ],
        ),
      ),
    );
  }
}
