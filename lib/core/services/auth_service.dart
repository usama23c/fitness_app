import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthService _authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Login' : 'Sign Up'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _authService.signOut,
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: StreamBuilder<User?>(
        stream: _authService.authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData && snapshot.data != null) {
            return UserProfileScreen(user: snapshot.data!);
          }

          return _buildAuthForm();
        },
      ),
    );
  }

  Widget _buildAuthForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            _isLogin ? 'Welcome Back' : 'Create Account',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 24),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: _submitAuthForm,
                  child: Text(_isLogin ? 'Login' : 'Sign Up'),
                ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              setState(() {
                _isLogin = !_isLogin;
              });
            },
            child: Text(_isLogin
                ? 'Don\'t have an account? Sign Up'
                : 'Already have an account? Login'),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          const Text(
            'Or continue with',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red),
                onPressed: () async {
                  setState(() => _isLoading = true);
                  await _authService.signInWithGoogle();
                  setState(() => _isLoading = false);
                },
                iconSize: 40,
              ),
              IconButton(
                icon:
                    const FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                onPressed: () async {
                  setState(() => _isLoading = true);
                  await _authService.signInWithFacebook();
                  setState(() => _isLoading = false);
                },
                iconSize: 40,
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.github),
                onPressed: () async {
                  setState(() => _isLoading = true);
                  await _authService.signInWithGithub();
                  setState(() => _isLoading = false);
                },
                iconSize: 40,
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              if (_emailController.text.isNotEmpty) {
                _authService.resetPassword(_emailController.text);
              } else {
                Fluttertoast.showToast(msg: 'Please enter your email first');
              }
            },
            child: const Text('Forgot Password?'),
          ),
        ],
      ),
    );
  }

  void _submitAuthForm() async {
    setState(() => _isLoading = true);

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: 'Please fill in all fields');
      setState(() => _isLoading = false);
      return;
    }

    if (_isLogin) {
      await _authService.signInWithEmail(email, password);
    } else {
      await _authService.signUpWithEmail(email, password);
    }

    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class UserProfileScreen extends StatelessWidget {
  final User user;

  const UserProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage:
                user.photoURL != null ? NetworkImage(user.photoURL!) : null,
            child: user.photoURL == null
                ? const Icon(Icons.person, size: 60)
                : null,
          ),
          const SizedBox(height: 20),
          Text(
            'Welcome,',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            user.displayName ?? user.email ?? 'User',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          if (user.email != null) Text(user.email!),
          const SizedBox(height: 20),
          Chip(
            label: Text(
              user.emailVerified ? 'Email Verified' : 'Email Not Verified',
              style: TextStyle(
                  color: user.emailVerified ? Colors.green : Colors.red),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              AuthService().signOut();
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Google SignIn instance
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  /// 🔹 Stream for listening auth changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// 🔹 Get currently logged-in user
  User? get currentUser => _auth.currentUser;

  /// 🔹 Check if user is logged in
  Future<bool> isLoggedIn() async => _auth.currentUser != null;

  // ==============================
  // 📌 EMAIL / PASSWORD AUTH
  // ==============================

  /// 🔹 Sign In with Email
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      return null;
    }
  }

  /// 🔹 Sign Up with Email
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // 🔹 Send email verification
      await userCredential.user?.sendEmailVerification();
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      return null;
    }
  }

  /// 🔹 Reset Password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      Fluttertoast.showToast(msg: '✅ Password reset email sent');
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    }
  }

  // ==============================
  // 📌 GOOGLE AUTH
  // ==============================
  Future<User?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      return null;
    } catch (e) {
      Fluttertoast.showToast(msg: '⚠️ Google sign in failed: $e');
      return null;
    }
  }

  // ==============================
  // 📌 FACEBOOK AUTH
  // ==============================
  Future<User?> signInWithFacebook() async {
    try {
      // Trigger the Facebook Sign-In flow
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status != LoginStatus.success) {
        return null;
      }

      // Get the access token
      final accessToken = result.accessToken;
      if (accessToken == null) return null;

      final OAuthCredential credential = FacebookAuthProvider.credential(
        accessToken.tokenString,
      );

      // Sign in to Firebase with the Facebook credential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      return null;
    } catch (e) {
      Fluttertoast.showToast(msg: '⚠️ Facebook sign in failed: $e');
      return null;
    }
  }

  // ==============================
  // 📌 GITHUB AUTH
  // ==============================
  Future<User?> signInWithGithub() async {
    try {
      // Firebase OAuth flow
      GithubAuthProvider githubProvider = GithubAuthProvider();
      final UserCredential userCredential =
          await _auth.signInWithProvider(githubProvider);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      return null;
    } catch (e) {
      Fluttertoast.showToast(msg: '⚠️ GitHub sign in failed: $e');
      return null;
    }
  }

  // ==============================
  // 📌 SIGN OUT (all providers)
  // ==============================
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      await FacebookAuth.instance.logOut();
      Fluttertoast.showToast(msg: '✅ Signed out successfully');
    } catch (e) {
      Fluttertoast.showToast(msg: '⚠️ Error signing out: $e');
    }
  }

  // ==============================
  // 📌 ERROR HANDLER
  // ==============================
  void _handleAuthError(FirebaseAuthException e) {
    String message;

    switch (e.code) {
      case 'email-already-in-use':
        message = '⚠️ Email already in use';
        break;
      case 'invalid-email':
        message = '⚠️ Invalid email format';
        break;
      case 'weak-password':
        message = '⚠️ Password is too weak (minimum 6 characters)';
        break;
      case 'user-not-found':
        message = '⚠️ No user found for that email';
        break;
      case 'wrong-password':
        message = '⚠️ Incorrect password';
        break;
      case 'network-request-failed':
        message = '⚠️ Network error. Please check your connection';
        break;
      case 'user-disabled':
        message = '⚠️ This user has been disabled';
        break;
      case 'account-exists-with-different-credential':
        message = '⚠️ Account already exists with different credential';
        break;
      case 'invalid-credential':
        message = '⚠️ Invalid credential';
        break;
      case 'operation-not-allowed':
        message = '⚠️ Operation not allowed';
        break;
      case 'user-mismatch':
        message = '⚠️ User mismatch';
        break;
      case 'requires-recent-login':
        message = '⚠️ Requires recent login';
        break;
      default:
        message = '⚠️ Authentication failed: ${e.message}';
    }

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
    );
  }
}
