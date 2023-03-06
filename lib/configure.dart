import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/firebase_options.dart';
import 'package:room_finder_flutter/get_it.dart';
import 'package:room_finder_flutter/provider/AuthProvider.dart';

Future<void> configure() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  final AuthProvider authProvider = AuthProvider(
      firebaseAuth: FirebaseAuth.instance,
      googleSignIn: GoogleSignIn(),
      prefs: prefs,
      firebaseFirestore: firebaseFirestore);

  getIt.registerSingleton<AuthProvider>(authProvider);
}
