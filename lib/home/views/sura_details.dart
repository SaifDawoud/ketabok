import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ketabok/style/my_theme.dart';

import '../data/models/sura.dart';

class SuraDetails extends StatelessWidget {
  static String routName = '/sura_details';

  //https://equran.id/api/v2/surat/1
  SuraDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final routArgus =
        ModalRoute.of(context)!.settings.arguments as Map<String, Sura>;
    late Sura? sura = routArgus['sura'];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset("assets/svgs/arrow_back.svg"),
        ),
        backgroundColor: MyTheme.darkScaffold,
        title: Text("${sura!.namaLatin}",
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    height: 265,
                    width: 350,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            stops: [
                              0,
                              .6,
                              1
                            ],
                            colors: [
                              MyTheme.startgradient,
                              MyTheme.middlegradient,
                              MyTheme.endgradient
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Positioned(

                    bottom: 0,
                    right: 0,
                    child: Opacity(
                        opacity: 0.06,
                        child: SvgPicture.asset(
                          "assets/svgs/home_quran.svg",
                          width: 345,
                          clipBehavior: Clip.hardEdge,
                        ))),
                Positioned(top: 10,right: 60,child: SvgPicture.asset("assets/svgs/basmalah.svg"))
              ],
            ),
          ),
        ],
      ),
      backgroundColor: MyTheme.darkScaffold,
    );
  }
}
