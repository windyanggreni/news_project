import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:windy_latihansatu/screen_page/page_login_api.dart';

import '../Model/ModelBerita.dart';
import '../utils/session_manager.dart';
import 'detail_berita.dart';

class PageListBerita extends StatefulWidget {
  const PageListBerita({Key? key}) : super(key: key);

  @override
  State<PageListBerita> createState() => _PageListBeritaState();
}

class _PageListBeritaState extends State<PageListBerita> {
  TextEditingController searchController = TextEditingController();
  List<Datum>? beritaList;
  String? username;
  List<Datum>? filteredBeritaList; // List berita hasil filter

  @override
  void initState() {
    super.initState();
    session.getSession();
    getDataSession();
  }

  Future getDataSession() async {
    await Future.delayed(const Duration(seconds: 1), () {
      session.getSession().then((value) {
        print('data sesi .. ' + value.toString());
        username = session.userName;
      });
    });
  }

  Future<List<Datum>?> getBerita() async {
    try {
      // Berhasil
      http.Response response = await http.get(
        Uri.parse("http://192.168.43.124/edukasi_server/getBerita.php"),
      );

      return modelBeritaFromJson(response.body).data;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'List Berita',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(5, 25, 54, 1.0),
        actions: [
          TextButton(onPressed: () {}, child: Text('Hi ... ${session.userName}', style: TextStyle(color: Colors.deepOrangeAccent), )),
          // Logout
          IconButton(
            onPressed: () {
              // Clear session
              setState(() {
                session.clearSession();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => PageLoginApi()),
                      (route) => false,
                );
              });
            },
            icon: Icon(Icons.exit_to_app),
            tooltip: 'Logout',
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  filteredBeritaList = beritaList
                      ?.where((element) =>
                  element.judul!
                      .toLowerCase()
                      .contains(value.toLowerCase()) ||
                      element.berita!
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getBerita(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Datum>?> snapshot) {
                if (snapshot.hasData) {
                  beritaList = snapshot.data;
                  if (filteredBeritaList == null) {
                    filteredBeritaList = beritaList;
                  }
                  return ListView.builder(
                    itemCount: filteredBeritaList!.length,
                    itemBuilder: (context, index) {
                      Datum data = filteredBeritaList![index];
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailBeritaPage(data),
                              ),
                            );
                          },
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(4),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network('http://192.168.43.124/edukasi_server/gambar_berita/${data.gambar}',
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                ),
                                ListTile(
                                  title: Text(
                                    '${data.judul}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange,
                                      fontSize: 18,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${data.berita}',
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
