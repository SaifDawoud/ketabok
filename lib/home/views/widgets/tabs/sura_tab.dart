import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ketabok/home/views/sura_details.dart';
import 'package:ketabok/style/my_theme.dart';

import '../../../data/models/sura.dart';

class SuraTab extends StatelessWidget {
  const SuraTab({super.key});

  Future<List<Sura>> getSurasList() async {
    String data = await rootBundle.loadString("assets/data/suras_list.json");

    return suraFromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sura>>(
      initialData: [],
      future: getSurasList(),
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return suraItem(context: context, sura: snapshot.data![index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Divider(
                    thickness: 1.2,
                    color: const Color(0xFF7B80AD).withOpacity(.35)),
              );
            },
            itemCount: snapshot.data!.length,
          ),
        );
      },
    );
  }

  Widget suraItem({required Sura sura, required BuildContext context}) =>
      InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return SuraDetails(sura: sura);
            }));
          },
          child: Row(
            children: [
              Stack(children: [
                SvgPicture.asset('assets/svgs/star.svg'),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("${sura.nomor}",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ]),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${sura.namaLatin}",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                      Row(
                        children: [
                          Text("${sura.tempatTurun}",
                              style: GoogleFonts.poppins(
                                  color: MyTheme.text,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(
                            width: 6,
                          ),
                          SvgPicture.asset("assets/svgs/dot.svg"),
                          const SizedBox(
                            width: 6,
                          ),
                          Text("${sura.jumlahAyat} Aya",
                              style: GoogleFonts.poppins(
                                  color: MyTheme.text,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Text("${sura.nama}",
                  style: GoogleFonts.amiri(
                      color: MyTheme.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold))
            ],
          ));
}
