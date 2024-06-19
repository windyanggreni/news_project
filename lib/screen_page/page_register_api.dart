import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:windy_latihansatu/Model/ModelRegister.dart';
import 'package:windy_latihansatu/screen_page/page_login_api.dart';

class PageRegisterApi extends StatefulWidget {
  const PageRegisterApi({Key? key}) : super(key: key);

  @override
  State<PageRegisterApi> createState() => _PageRegisterApiState();
}

class _PageRegisterApiState extends State<PageRegisterApi> {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtNama = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtNohp = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool isLoading = false;

  Future<ModelRegister?> registerAccount() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response response = await http.post(
        Uri.parse("http://192.168.43.124/edukasi_server2/register.php"),
        body: {
          "nama": txtNama.text,
          "username": txtUsername.text,
          "password": txtPassword.text,
          "email": txtEmail.text,
          "nohp": txtNohp.text,
        },
      );
      ModelRegister data = modelRegisterFromJson(response.body);
      if (data.value == 1) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${data.message}")),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const PageLoginApi()),
                (route) => false,
          );
        });
      } else if (data.value == 2) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${data.message}")),
          );
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${data.message}")),
          );
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade900, Colors.purple.shade600],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: keyForm,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'REGISTER',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  buildTextField(
                    controller: txtNama,
                    hintText: 'Full Name',
                    icon: Icons.person,
                  ),
                  SizedBox(height: 20),
                  buildTextField(
                    controller: txtUsername,
                    hintText: 'Username',
                    icon: Icons.account_circle,
                  ),
                  SizedBox(height: 20),
                  buildTextField(
                    controller: txtPassword,
                    hintText: 'Password',
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  buildTextField(
                    controller: txtEmail,
                    hintText: 'Email',
                    icon: Icons.email,
                  ),
                  SizedBox(height: 20),
                  buildTextField(
                    controller: txtNohp,
                    hintText: 'Phone Number',
                    icon: Icons.phone,
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : ElevatedButton(
                      onPressed: () {
                        if (keyForm.currentState?.validate() == true) {
                          setState(() {
                            registerAccount();
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.purple.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 15, horizontal: 40),
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PageLoginApi()),
                        );
                      },
                      child: Text(
                        'Login here',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: (val) => val!.isEmpty ? 'Cannot be empty' : null,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon, color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
