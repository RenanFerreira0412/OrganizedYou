import 'package:flutter/material.dart';
import 'package:organized_you/services/auth_service.dart';
import 'package:organized_you/ui/auth/login_form.dart';
import 'package:organized_you/ui/auth/register_form.dart';
import 'package:provider/provider.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class AuthUI extends StatefulWidget {
  const AuthUI({super.key});

  @override
  State<AuthUI> createState() => _AuthUIState();
}

class _AuthUIState extends State<AuthUI> {
  // Gerenciador dos formulários
  final formLoginKey = GlobalKey<FormState>();
  final formRegisterKey = GlobalKey<FormState>();

  // Controladores
  final name = TextEditingController();
  final emailLogin = TextEditingController();
  final passwordLogin = TextEditingController();
  final emailRegister = TextEditingController();
  final passwordRegister = TextEditingController();
  final confirmPassword = TextEditingController();

  // Textos
  bool isLogin = true;
  late String title;
  late String actionButton;
  late String toggleButton;
  late Widget form;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }

  setFormAction(bool acao) {
    setState(() {
      isLogin = acao;
      if (isLogin) {
        title = 'Bem vindo';
        actionButton = 'Login';
        toggleButton = 'Ainda não tem conta? Cadastre-se agora.';
        form = LoginForm(
            email: emailLogin, password: passwordLogin, formKey: formLoginKey);
      } else {
        title = 'Crie sua conta';
        actionButton = 'Cadastrar';
        toggleButton = 'Voltar ao Login.';
        form = RegisterForm(
            name: name,
            email: emailRegister,
            password: passwordRegister,
            confirmPassword: confirmPassword,
            formKey: formRegisterKey);
      }
    });
  }

  login() async {
    setState(() => loading = true);
    try {
      await context
          .read<AuthService>()
          .login(emailLogin.text, passwordLogin.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  registrar() async {
    setState(() => loading = true);
    try {
      await context
          .read<AuthService>()
          .registrar(name.text, emailRegister.text, passwordRegister.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.5,
                ),
              ),
              TextButton(
                onPressed: () => setFormAction(!isLogin),
                child: Text(toggleButton),
              ),
              form,
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (isLogin) {
                      if (formLoginKey.currentState!.validate()) {
                        login();
                      }
                    } else {
                      if (formRegisterKey.currentState!.validate()) {
                        registrar();
                      }
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: (loading)
                        ? [
                            const Padding(
                              padding: EdgeInsets.all(16),
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ]
                        : [
                            const Icon(Icons.check),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                actionButton,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                  ),
                ),
              ),
              if (isLogin) ...[
                SocialLoginButton(
                  text: 'Conectar-se com Google',
                  borderRadius: 10,
                  buttonType: SocialLoginButtonType.google,
                  onPressed: () async {
                    await context.read<AuthService>().signInWithGoogle();
                  },
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
