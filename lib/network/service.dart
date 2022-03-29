import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import '../common/AlertView.dart';
import 'package:http/http.dart' as http;

import '../common/constants.dart';

class Servicereq {
  connectivityFunc(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print('mobile');
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print('wifi');
    } else if (connectivityResult == ConnectivityResult.none) {
      print('no connect');
      Navigator.of(context).pop();
      alertOpen.showAlertOnebtn(
          context: context,
          title: Constants.appname,
          message: validationMsg.noInternet,
          btnTitle: 'Ok');
    }
  }

  Future<http.Response> fetchdata(
      String method,
      String url,
      Map<String, String> body,
      BuildContext context) async {
    connectivityFunc(context);

    String mainurl = reqserver.baseurl + url;
    var response = await http.post(Uri.parse(mainurl), body: body);

    return response;
  }

  Future<http.Response> fetchdataget(
      String method, String url, BuildContext context) async {
    connectivityFunc(context);

    String mainurl = reqserver.baseurl + url;
    var response = await http.get(Uri.parse(mainurl));

    return response;
  }

  Future<http.Response> fetchdatawithHeader(
      String method,
      String url,
      Map<String, String> body,
      Map<String, String> header,
      BuildContext context) async {
    connectivityFunc(context);
    String mainurl = reqserver.baseurl + url;
    print('main url${mainurl}');
    var response = await http.post(Uri.parse(mainurl), body: body, headers: header);
    print('response${response.body}');
    print('status code${response.statusCode}');
    return response;
  }

  Future<http.Response> fetchGetdata(
      String method,
      String url,
      Map<String, String> body,
      BuildContext context,
      Map<String, String> header) async {
    connectivityFunc(context);
    String mainurl = reqserver.baseurl + url;
    print('get data');
    var uri = Uri.http(reqserver.getBase1, '${reqserver.getBase2}${url}', body);
    print('uri${uri}');
    //uri.replace(queryParameters: body);
    print(uri);
    print(url);
    var response = await http.get(uri, headers: header);

    return response;
  }
}
