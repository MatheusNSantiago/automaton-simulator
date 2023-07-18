import 'package:automata_simulator/constants.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ant_design.dart';

class SignupModal extends StatefulWidget {
  const SignupModal({super.key});

  @override
  State<SignupModal> createState() => _SignupModalState();
}

class _SignupModalState extends State<SignupModal> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kButtonBorderRadius),
      ),
      child: SizedBox(
        width: 440,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 75),
                Text(
                  "Registrar",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 35),
                CustomFormField(
                  label: "Nome",
                  icon: AntDesign.user_outlined,
                  keyboardType: TextInputType.name,
                  controller: _controllerName,
                  onEditingComplete: _focusNodeEmail.requestFocus,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor, insira seu nome.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomFormField(
                  label: "Email",
                  icon: AntDesign.mail_outlined,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: _focusNodeEmail,
                  controller: _controllerEmail,
                  onEditingComplete: _focusNodePassword.requestFocus,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor, insira seu email.";
                    } else if (!(value.contains('@') && value.contains('.'))) {
                      return "Email inválido";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomFormField(
                  label: "Senha",
                  icon: AntDesign.lock_outlined,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _obscurePassword,
                  focusNode: _focusNodePassword,
                  controller: _controllerPassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                    icon: _obscurePassword
                        ? const Iconify(
                            AntDesign.eye_outlined,
                            color: Colors.white,
                          )
                        : const Iconify(
                            AntDesign.eye_invisible_outlined,
                            color: Colors.white,
                          ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor, insira sua senha.";
                    } else if (value.length < 8) {
                      return "Senha deve ter no mínimo 8 caracteres.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(kButtonBorderRadius),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          /* _boxAccounts.put(
                          _controllerUsername.text,
                          _controllerConFirmPassword.text,
                        ); */

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              width: 250,
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(kButtonBorderRadius),
                              ),
                              behavior: SnackBarBehavior.floating,
                              content: const Text(
                                "Conta criada com sucesso!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );

                          _formKey.currentState?.reset();
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Registrar",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Já possui uma conta?"),
                        const SizedBox(width: 5),
                        TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(kButtonBorderRadius),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "Entrar",
                            style: TextStyle(
                                color: Colors.blue[400],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _controllerName.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }
}

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    required this.label,
    required this.icon,
    required this.controller,
    required this.validator,
    this.obscureText = false,
    this.focusNode,
    this.onEditingComplete,
    this.keyboardType,
    this.suffixIcon,
    super.key,
  });

  final String label;
  final String icon;
  final TextEditingController controller;
  final VoidCallback? onEditingComplete;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 13),
          child: Iconify(icon, color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kButtonBorderRadius),
        ),
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kButtonBorderRadius),
          borderSide: const BorderSide(color: kButtonBorderColor),
        ),
        hoverColor: Colors.blue,
        focusColor: Colors.yellow,
      ),
      validator: validator,
      onEditingComplete: onEditingComplete,
    );
  }
}
