import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    } else {
      // User canceled the picker
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
              label: const Text('Select Your Excel File'),
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
          ],
        ),
      ),
    );
  }
}
