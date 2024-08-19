import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Links',
      theme: ThemeData(
        primaryColor: Colors.grey.shade900,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    //* variables
    double screenWidth = MediaQuery.of(context).size.width;
    TextStyle generalStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white);
    TextStyle headingStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.white);
    TextStyle silenceStyle = const TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: Colors.white70);

    //* URI paths Linklerini yol olarak buraya ekle
    final Uri defaultLink = Uri(scheme: 'https', host: 'www.instagram.com', path: '/nsyasiyor');

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              flex: 14,
              child: Container(
                width: screenWidth,
                decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      //Buradaki resmi değiştrerek kullan.
                      foregroundImage: AssetImage("assets/placeholder.jpeg"),
                    ),
                    //İsim Soyisim ve Bio ile ilgili kısım
                    AutoSizeText("Name Surname", style: GoogleFonts.lexend(textStyle: headingStyle),),
                    AutoSizeText("Spec1 | Spec2 | Spec3", style: GoogleFonts.lexend(textStyle: silenceStyle),),
                  ],
                ),
              )
          ),
          Expanded(
            flex: 28,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //Buraya Butonları Listele!
                    LaunchButton(buttonText: "Default Button", textStyle: generalStyle, onPressed: ()=>_launchInBrowser(defaultLink)),
                    const SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          ),
          //En Alt Bilgi Sectionu
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color(0xffef32d9),
                    Color(0xffc89fffd),
                  ],
                  tileMode: TileMode.mirror,
                ),
              ),
              child: Center(
                child: Text("Copyright © 2024 | by ns", style: GoogleFonts.lexend(textStyle: const TextStyle(color: Colors.white), fontSize: 10),),
              ),
            ),
          ),
        ],
      ),
    );
  }
//Launch Fonksiyonu
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}

//Buttonları komponent olarak tanımlayan sınıf
class LaunchButton extends StatelessWidget {
  const LaunchButton({super.key, required this.buttonText, required this.textStyle, required this.onPressed});
  final String buttonText;
  final TextStyle textStyle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {

    //* variables
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color(0xff12c2e9),
              Color(0xffc471ed),
              Color(0xfff64f59),
            ],
            tileMode: TileMode.mirror,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Colors.transparent,
            minimumSize: Size(width < 1000 ? (width/4)*3 : 750, 70),
          ),
          child: AutoSizeText(buttonText, style: GoogleFonts.lexend(textStyle: textStyle), maxLines: 1,),
        ),
      ),
    );
  }
}