import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:google_sign_in/google_sign_in.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  User? user;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  final googleSignIn = GoogleSignIn();

  UserCredential? _user;

  UserCredential get googleUser => _user!;

  // Verificação do estado do usuário (autenticado ou não)
  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      user = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    user = _auth.currentUser;
    notifyListeners();
  }

  handleAuthError(FirebaseException e) {
    switch (e.code) {
      case 'invalid-credential':
        throw AuthException('E-mail ou senha inválidos.');

      case 'invalid-email':
        throw AuthException('Email inválido.');

      case 'user-not-found':
        throw AuthException('Usuário não encontrado.');

      case 'wrong-password':
        throw AuthException('Senha incorreta!');

      case 'email-already-in-use':
        throw AuthException('Este email já está cadastrado.');

      case 'weak-password':
        throw AuthException('A senha precisa ter no mínimo 6 caracteres!');

      case 'account-exists-with-different-credential':
        throw AuthException('A conta já existe com uma credencial diferente.');

      default:
        throw AuthException('Erro desconhecido');
    }
  }

  // Cadastro de conta
  register(String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      _getUser();
      addUser(userCredential.user!.uid, name, email);
    } on FirebaseAuthException catch (e) {
      handleAuthError(e);
    }
  }

  // Logar na conta
  login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _getUser();
    } on FirebaseAuthException catch (e) {
      handleAuthError(e);
    }
  }

  // Sair da conta
  logout() async {
    await _auth.signOut();
    await googleSignIn.signOut();
    _getUser();
  }

  // Adicionando os dados do usuário no banco de dados
  addUser(String? uid, String? name, String? email) async {
    Timestamp timeNow = Timestamp.fromDate(DateTime.now());
    await users.doc(uid).set({
      'name': name,
      'email': email,
      'creation_date': timeNow,
    });
  }

  // Trocar de senha
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      debugPrint('$e');

      handleAuthError(e);
    }
  }

  // Login com o Google
  Future<void> signInWithGoogle() async {
    if (kIsWeb) {
      // Create a new provider
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      try {
        // Once signed in, return the UserCredential
        final UserCredential userCredential =
            await _auth.signInWithPopup(googleProvider);

        _user = userCredential;

        bool userExist = await isNewUser(userCredential.user?.uid);

        if (!userExist) {
          debugPrint('Novo usuário');

          addUser(userCredential.user?.uid, userCredential.user?.displayName,
              userCredential.user?.email);
        }

        _getUser();
      } on FirebaseAuthException catch (e) {
        handleAuthError(e);
      }
    } else {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      try {
        // Once signed in, return the UserCredential
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        _user = userCredential;

        bool userExist = await isNewUser(userCredential.user?.uid);

        if (!userExist) {
          debugPrint('Novo usuário');

          addUser(userCredential.user?.uid, userCredential.user?.displayName,
              userCredential.user?.email);
        }

        _getUser();
      } on FirebaseAuthException catch (e) {
        handleAuthError(e);
      }
    }
  }

  // Tratando os erros account-exists-with-different-credential
  void accountError(FirebaseAuthException e) async {
    debugPrint('erro ${e.toString()}');
    if (e.code == 'account-exists-with-different-credential') {
      // A conta já existe com uma credencial diferente
      String? email = e.email;
      AuthCredential? pendingCredential = e.credential;

      // Obtenha uma lista de quais métodos de login existem para o usuário conflitante
      List<String> userSignInMethods =
          await _auth.fetchSignInMethodsForEmail(email!);

      // O primeiro método na lista será o recomendado para ser utilizado
      if (userSignInMethods.first == 'password') {
        // Senha informada pelo usuário
        String password = "...";

        // Logando o usuário na sua conta com a sua senha
        UserCredential userCredencial = await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        // Vincule a credencial pendente à conta existente
        await userCredencial.user!.linkWithCredential(pendingCredential!);

        _getUser();
      }
    }
  }

  // Função que verifica se o usuario ja existe no banco ou nao
  Future<bool> isNewUser(String? uid) async {
    try {
      var doc = await users.doc(uid).get();

      return doc.exists;
    } catch (e) {
      rethrow;
    }
  }
}
