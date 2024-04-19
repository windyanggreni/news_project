import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class FormRegister extends StatefulWidget {
  const FormRegister({super.key});
  @override
  State<FormRegister> createState() => _FormRegisterState();
}
class _FormRegisterState extends State<FormRegister> {
  String? valAgama, valJk;
  TextEditingController fullname = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController tglLahir = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  Future selectDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2100));
    if (pickedDate != null) {
      setState(() {
        tglLahir.text = DateFormat("dd-MM-yyyy").format(pickedDate);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Register"),
        backgroundColor: Colors.green,
      ),
      body: Form(
        key: keyForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: fullname,
                  validator: (val) {
                    return val!.isEmpty ? "tidak boleh kosong" :
                    null;
                  },
                  decoration: InputDecoration(
                      hintText: "Fullname",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: username,
                  validator: (val) {
                    return val!.isEmpty ? "tidak boleh kosong" :
                    null;
                  },
                  decoration: InputDecoration(
                      hintText: "Username",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: email,
                  validator: (val) {
                    return val!.isEmpty ? "tidak boleh kosong" :
                    null;
                  },
                  decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  onTap: () {
                    selectDate();
                  },
                  controller: tglLahir,
                  validator: (val) {
                    return val!.isEmpty ? "tidak boleh kosong" :
                    null;
                  },
                  decoration: InputDecoration(
                      hintText: "Tanggal Lahir",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  obscureText: true,
                  controller: password,
                  validator: (val) {
                    return val!.isEmpty ? "tidak boleh kosong" :
                    null;
                  },
                  decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 65,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color:
                      Colors.black54),
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton(
                      value: valAgama,
                      underline: Container(),
                      isExpanded: true,
                      hint: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Pilih agama"),
                      ),
                      items: [
                        "Islam",
                        "Kristen Protestan",
                        "Kristen Katolik",
                        "Hindu",
                        "Budha",
                        "Konghucu"
                      ].map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(e),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          valAgama = val;
                        });
                      }),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: RadioListTile(
                        value: "Laki-laki",
                        groupValue: valJk,
                        onChanged: (val) {
                          setState(() {
                            valJk = val;
                          });
                        },
                        activeColor: Colors.blue,
                        title: const Text("Laki-laki"),
                      ),
                    ),
                    Flexible(
                        child: RadioListTile(
                          value: "Perempuan",
                          groupValue: valJk,
                          onChanged: (val) {
                            setState(() {
                              valJk = val;
                            });
                          },
                          activeColor: Colors.green,
                          title: const Text("Perempuan"),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                MaterialButton(
                  color: Colors.green,
                  minWidth: 200,
                  height: 45,
                  onPressed: () {
                    if (keyForm.currentState?.validate() == true) {
                      if (valJk != null && valAgama != null) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Data Register"),
                                content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                Text("Fullname :${fullname.text}"),
                                Text("Username :${username.text}"),
                                Text("Email : ${email.text}"),
                                Text("Password :${password.text}"),
                                    Text("Agama : $valAgama"),
                                Text("Jenis Kelamin : $valJk"),
                                Text("Tanggal Lahir :${tglLahir.text}")
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Dismiss"))
                                ],
                              );
                            });
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                            content: Text("Pilih agama dan jenis kelamin"),
                              backgroundColor: Colors.green,
                            ));
                        }
                        }
                        },
                  child: const Text("SIMPAN"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}