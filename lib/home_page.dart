import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_service.dart';
import 'post_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleSignInAccount? _currentUser;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _authService.googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
    });
    _authService.googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HI Bank Test'),
        actions: <Widget>[
          _currentUser != null
              ? IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: () async {
                    await _authService.signOut();
                  },
                )
              : Container()
        ],
      ),
      body: Center(
        child: _currentUser != null
            ? const PostsPage()
            : ElevatedButton(
                child: const Text('Login with Google'),
                onPressed: () async {
                  await _authService.signInWithGoogle();
                },
              ),
      ),
    );
  }
}
