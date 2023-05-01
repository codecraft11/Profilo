import 'package:busniess_card_app/Bindings/all_bindings.dart';
import 'package:busniess_card_app/Utils/global_veriables.dart';
import 'package:busniess_card_app/Views/VisiterUser/profile_view.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';

class DynamicLink {
  //! Creating Dynamic links

  Future<String> createDynamicLink(String uid) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://finalyear.page.link/',
      link: Uri.parse(
          'https://final-year-project-fd15d.web.app/userprofile?userName=$uid'),
      androidParameters: AndroidParameters(
        fallbackUrl: Uri.parse(
            'https://final-year-project-fd15d.web.app/userprofile?userName=$uid'),
        packageName: 'com.example.business_card_app',
        minimumVersion: 1,
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.example.business_card_app',
        minimumVersion: '1',
      ),
    );

    final ShortDynamicLink shortLink = await parameters.buildShortLink();

    Uri url = shortLink.shortUrl;
    return url.toString();
  }

  //! Handling Dynamic links
  void handleDynamicLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null && deepLink.queryParameters != null) {
      var isProfile = deepLink.pathSegments.contains('userprofile');
      if (isProfile) {
        var userName = deepLink.queryParameters['userName'];
        print("init $userName");

        if (userName != null) {
          visitUserID.value = userName;
          Get.to(() => ProfileView(), binding: VisitUserBinding());
        }
      }
    }

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deepLink = dynamicLink?.link;

      if (deepLink != null && deepLink.queryParameters != null) {
        var isProfile = deepLink.pathSegments.contains('userprofile');
        if (isProfile) {
          var userName = deepLink.queryParameters['userName'];
          print("onlink $userName");

          if (userName != null) {
            visitUserID.value = userName;
            Get.to(() => ProfileView(), binding: VisitUserBinding());
          }
        }
      }
    }, onError: (OnLinkErrorException e) async {
      print("Here:is Error" + e.toString());
      print(e.message);
    });
  }
}
