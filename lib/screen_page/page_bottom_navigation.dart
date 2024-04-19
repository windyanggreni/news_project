import 'package:flutter/material.dart';
import 'package:windy_latihansatu/screen_page/page_list_pegawai.dart';
import 'package:windy_latihansatu/screen_page/page_profil_user.dart';
import 'package:windy_latihansatu/screen_page/page_list_berita.dart';

class PageBottomNavigationBar extends StatefulWidget {
  const PageBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<PageBottomNavigationBar> createState() => _PageBottomNavigationBarState();
}

class _PageBottomNavigationBarState extends State<PageBottomNavigationBar> with SingleTickerProviderStateMixin{
  late TabController tabController;

  @override
  void initState(){
    super.initState();
    tabController = TabController(length: 4, vsync: this); // Ubah length menjadi 4 karena menambahkan satu tab baru
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: [
          PageListBerita(),
          PageKaryawan(),
          //CustomeGrid(),
          PageProfileUser(),
           // Tambahkan PageListBerita sebagai salah satu tab
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: TabBar(
          isScrollable: true,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          controller: tabController,
          tabs: const [
            Tab(
              text: "List Berita",
              icon: Icon(Icons.article),
            ),
            Tab(
              text: "List Pegawai", // Tambahkan label untuk tab baru
              icon: Icon(Icons.group),
            ),
            Tab(
              text: "Profil User",
              icon: Icon(Icons.person),
            ),


          ],
        ),
      ),
    );
  }
}
