import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ketabok/home/views/widgets/tabs/hijb_tab.dart';
import 'package:ketabok/home/views/widgets/tabs/page_tab.dart';
import 'package:ketabok/home/views/widgets/tabs/para_tab.dart';
import 'package:ketabok/home/views/widgets/tabs/sura_tab.dart';
import 'package:ketabok/style/my_theme.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      bottomNavigationBar: myBottomNavBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: DefaultTabController(
          length: 4,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: sayingHi(),
              ),
              SliverAppBar(
                backgroundColor: MyTheme.darkScaffold,
                automaticallyImplyLeading: false,
                surfaceTintColor: MyTheme.darkScaffold,
                elevation: 0,
                pinned: true,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: TabBar(
                      indicatorColor: MyTheme.primaryColor,
                      indicatorWeight: 3,
                      dividerColor: Colors.grey.withOpacity(0.1),
                      unselectedLabelColor: MyTheme.text,
                      labelColor: Colors.white,
                      tabs: [
                        myTab(lable: "Sura"),
                        myTab(lable: "Para"),
                        myTab(lable: "Page"),
                        myTab(lable: "Hijb"),
                      ]),
                ),
              )
            ],
            body: TabBarView(
              children: [SuraTab(), ParaTab(), PageTab(), HijbTab()],
            ),
          ),
        ),
      ),
    );
  }

  Tab myTab({required String lable}) {
    return Tab(
      child: Text(
        lable,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Column sayingHi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Asslamualaikum",
          style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: const Color(0xffA19CC5)),
        ),
        const SizedBox(
          height: 2,
        ),
        Text("Saif Dawoud",
            style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
        const SizedBox(
          height: 16,
        ),
        Center(
          child: Stack(
            children: [
              Container(
                height: 131,
                width: 326,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(stops: [
                      0,
                      .6,
                      1
                    ], colors: [
                      MyTheme.startgradient,
                      MyTheme.middlegradient,
                      MyTheme.endgradient
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(10)),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: SvgPicture.asset("assets/svgs/home_quran.svg")),
              Positioned(
                top: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/svgs/small_book.svg'),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Last Read',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Al-Fatihah',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Ayat No: 1',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  BottomNavigationBar myBottomNavBar() {
    return BottomNavigationBar(
      backgroundColor: MyTheme.bottomNavBarBG,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
            label: "quran",
            icon: SvgPicture.asset("assets/svgs/quran_nav_icon.svg")),
        BottomNavigationBarItem(
            label: "lamp", icon: SvgPicture.asset("assets/svgs/lamp.svg")),
        BottomNavigationBarItem(
            label: "salah",
            icon: SvgPicture.asset("assets/svgs/salah_icon.svg")),
        BottomNavigationBarItem(
            label: "doaa", icon: SvgPicture.asset("assets/svgs/doaa_icon.svg")),
        BottomNavigationBarItem(
            label: "bookmark",
            icon: SvgPicture.asset("assets/svgs/bookmark.svg")),
      ],
    );
  }

  AppBar myAppBar() {
    return AppBar(
      backgroundColor: MyTheme.darkScaffold,
      leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset("assets/svgs/burgerIcon.svg")),
      title: Text("Quran App",
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
      actions: [
        IconButton(
            onPressed: () {}, icon: SvgPicture.asset("assets/svgs/search.svg"))
      ],
    );
  }
}
