import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

Future<Uint8List?> pickImage(ImageSource source)async{
XFile? image =  await ImagePicker().pickImage(source: source);
if(image != null){
  return await image.readAsBytes();
}
return null;
}