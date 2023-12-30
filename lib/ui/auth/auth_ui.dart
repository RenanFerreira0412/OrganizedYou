import 'package:flutter/material.dart';
import 'package:organized_you/services/auth_service.dart';
import 'package:organized_you/theme/app_theme.dart';
import 'package:organized_you/ui/auth/login_form.dart';
import 'package:organized_you/ui/auth/register_form.dart';
import 'package:organized_you/ui/auth/reset_password_form.dart';
import 'package:organized_you/utils/utils.dart';
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
  final formResetPasswordKey = GlobalKey<FormState>();

  // Controladores
  final name = TextEditingController();
  final emailLogin = TextEditingController();
  final passwordLogin = TextEditingController();
  final emailRegister = TextEditingController();
  final passwordRegister = TextEditingController();
  final confirmPassword = TextEditingController();
  final emailResetPassword = TextEditingController();

  // Variáveis de Controle
  bool isLogin = true;
  bool isResetPasswordForm = false;
  bool loading = false;

  late String title;
  late String actionButton;
  late String toggleButton;
  late String toggleResetPasswordButton;
  late Widget form;

  @override
  void initState() {
    super.initState();
    setFormAction(true, false);
  }

  setFormAction(bool acao, bool forgotPswForm) {
    setState(() {
      isLogin = acao;
      isResetPasswordForm = forgotPswForm;

      if (isLogin) {
        if (isResetPasswordForm) {
          title = 'Recuperar senha';
          actionButton = 'Enviar';
          toggleButton = 'Ainda não tem conta? Cadastre-se agora.';
          toggleResetPasswordButton = "Voltar";
          form = ResetPasswordForm(
              email: emailResetPassword, formKey: formResetPasswordKey);
        } else {
          title = 'Bem vindo';
          actionButton = 'Login';
          toggleButton = 'Ainda não tem conta? Cadastre-se agora.';
          toggleResetPasswordButton = 'Esqueceu sua senha ?';
          form = LoginForm(
              email: emailLogin,
              password: passwordLogin,
              formKey: formLoginKey);
        }
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
      Utils.schowSnackBar(e.message);
    }
  }

  register() async {
    setState(() => loading = true);
    try {
      await context
          .read<AuthService>()
          .register(name.text, emailRegister.text, passwordRegister.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      Utils.schowSnackBar(e.message);
    }
  }

  signInWithGoogle() async {
    try {
      await context.read<AuthService>().signInWithGoogle();
    } on AuthException catch (e) {
      Utils.schowSnackBar(e.message);
    }
  }

  resetPassword() async {
    try {
      await context.read<AuthService>().resetPassword(emailResetPassword.text);

      String message =
          'Pronto! Um link para criação de uma nova senha foi enviado para o seu e-mail.';

      Utils.schowSnackBar(message);
    } on AuthException catch (e) {
      Utils.schowSnackBar(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: AppTheme.typo.bold(35, Colors.black, 1.5, -1.5),
                  ),
                  if (!isResetPasswordForm) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: TextButton(
                        onPressed: () => setFormAction(!isLogin, false),
                        child: Text(toggleButton),
                      ),
                    )
                  ] else ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Um link de recuperação de senha será enviado para o endereço de e-mail fornecido por você.',
                        textAlign: TextAlign.start,
                        style:
                            AppTheme.typo.regular(15, Colors.black87, 1.5, 1.5),
                      ),
                    )
                  ],
                  form,
                  if (isLogin) ...[
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () =>
                              setFormAction(isLogin, !isResetPasswordForm),
                          child: Text(
                            toggleResetPasswordButton,
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ],
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      onPressed: () {
                        if (isLogin) {
                          if (isResetPasswordForm) {
                            if (formResetPasswordKey.currentState!.validate()) {
                              resetPassword();
                              cleanForm();
                            }
                          } else {
                            if (formLoginKey.currentState!.validate()) {
                              login();
                              cleanForm();
                            }
                          }
                        } else {
                          if (formRegisterKey.currentState!.validate()) {
                            register();
                            cleanForm();
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: (loading)
                            ? [
                                const Padding(
                                  padding: EdgeInsets.all(15),
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
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    actionButton,
                                    style: AppTheme.typo.button,
                                  ),
                                ),
                              ],
                      ),
                    ),
                  ),
                  if (!isResetPasswordForm && isLogin) ...[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Expanded(child: Divider()),
                          Utils.addHorizontalSpace(10),
                          const Text('Ou'),
                          Utils.addHorizontalSpace(10),
                          const Expanded(child: Divider()),
                        ],
                      ),
                    ),
                    SocialLoginButton(
                      text: 'Conectar-se com Google',
                      fontSize: 15,
                      borderRadius: 5,
                      buttonType: SocialLoginButtonType.google,
                      onPressed: () => signInWithGoogle(),
                    ),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void cleanForm() {
    name.clear();
    emailLogin.clear();
    passwordLogin.clear();
    emailRegister.clear();
    passwordRegister.clear();
    confirmPassword.clear();
    emailResetPassword.clear();
  }
}
