import 'package:flutter/material.dart';
import 'package:windy_latihansatu/screen_page/page_bottom_navigation.dart';
import 'package:windy_latihansatu/screen_page/page_register_api.dart';
import 'package:http/http.dart' as http;
import '../Model/ModelLogin.dart';
import '../utils/session_manager.dart';

class PageLoginApi extends StatefulWidget {
  const PageLoginApi({Key? key}) : super(key: key);

  @override
  State<PageLoginApi> createState() => _PageLoginApiState();
}

class _PageLoginApiState extends State<PageLoginApi> {
  final TextEditingController txtUsername = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> loginAccount() async {
    try {
      setState(() {
        isLoading = true;
      });
      final http.Response response = await http.post(
        Uri.parse('http://192.168.43.124/edukasi_server/login.php'),
        body: {
          "username": txtUsername.text,
          "password": txtPassword.text,
        },
      );
      final ModelLogin data = modelLoginFromJson(response.body);
      if (data.value == 1) {
        setState(() {
          isLoading = false;
          session.saveSession(data.value ?? 0, data.id ?? "", data.username ?? "");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${data.message}')),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => PageBottomNavigationBar()),
                (route) => false,
          );
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${data.message}')),
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
      // appBar: AppBar(
      //   backgroundColor: Colors.cyan,
      //   title: Text('Form Login'),
      // ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.all(45), // Sesuaikan jarak sesuai kebutuhan
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 44, // Ubah sesuai kebutuhan
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(5, 25, 54, 1.0), // Warna biru donker
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.person, color: Colors.grey),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        validator: (val) => val!.isEmpty ? "Tidak boleh kosong" : null,
                        controller: txtUsername,
                        decoration: InputDecoration(
                          hintText: 'Input Username',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.lock, color: Colors.grey),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        validator: (val) => val!.isEmpty ? "Tidak boleh kosong" : null,
                        controller: txtPassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Input Password',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Center(
                  child: isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        loginAccount();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Mengatur warna latar belakang tombol menjadi biru
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // Mengatur sudut tombol
                      ),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20), // Padding tombol
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 18, color: Colors.white), // Ukuran teks dan warna teks tombol
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(width: 1, color: Colors.green),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PageRegisterApi()));
          },
          child: Text('Anda belum punya account? Silakan Register'),
        ),
      ),
    );
  }
}
