import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadData(Map<String, String> _datamap) async {
  await FirebaseFirestore.instance.collection('templates').add(_datamap);
}

Future<void> fetchData(String _collection, String _dataname) async {
  FirebaseFirestore.instance.collection(_collection).get().then(
        (QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach(
            (doc) {
              return doc[_dataname];
            },
          ),
        },
      );
}

Future<void> editData(Map<String, String> _newDatamap, String _oldData) async {
  await FirebaseFirestore.instance
      .collection('templates')
      .doc(_oldData)
      .update(_newDatamap);
}

Future<void> deleteData(String _datatodelete) async {
  await FirebaseFirestore.instance
      .collection('templates')
      .doc(_datatodelete)
      .delete();
}
