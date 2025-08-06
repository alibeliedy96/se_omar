import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mr_omar/language/app_localizations.dart';



class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);


  Future<void> _launchWhatsApp(BuildContext context) async {
    const String phoneNumber = "+201024162721";
    String message = Loc.alized.hello_need_help_with;

    final Uri whatsappUrl = Uri.parse(
        "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}");

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text("لا يمكن فتح واتساب.")),
      // );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          Loc.alized.help_center,
          // style: TextStyles(context).getTitleStyle(),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            const Center(
              child: FaIcon(
                FontAwesomeIcons.whatsapp,
                size: 100,
                color: Color(0xFF25D366),
              ),
            ),
            const SizedBox(height: 32),


            Text(
              Loc.alized.need_help,
              textAlign: TextAlign.center,
              // style: TextStyles(context).getBoldStyle().copyWith(fontSize: 24),
            ),
            const SizedBox(height: 16),

            // --- 4. نص وصفي لطيف ---
            Text(
              Loc.alized.here_to_help_contact_us_directly_via_whatsApp,
              textAlign: TextAlign.center,
              // style: TextStyles(context).getDescriptionStyle().copyWith(
              //   fontSize: 16,
              //   color: Colors.grey[700],
              //   height: 1.5,
              // ),
            ),
            const SizedBox(height: 48),


            ElevatedButton.icon(
              onPressed: () => _launchWhatsApp(context),
              icon: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white),
              label:   Text( Loc.alized.contact_us_via_whatsapp),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF25D366),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'YourAppFont',
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}