import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadingData(String _layoutType, String _celebrationType,
    String _colorPalette, String _fontStyle) async {
  await FirebaseFirestore.instance.collection("templates").add({
    'layoutType': _layoutType,
    'celebrationType': _celebrationType,
    'colorPalette': _colorPalette,
    'fontStyle': _fontStyle,
  });
}

Future<void> editProduct(bool _isFavourite, String id) async {
  await FirebaseFirestore.instance
      .collection("templates")
      .doc(id)
      .update({"isFavourite": !_isFavourite});
}

Future<void> deleteProduct(DocumentSnapshot doc) async {
  await FirebaseFirestore.instance.collection("products").doc(doc.id).delete();
}
