import 'dart:convert';

import 'package:http/http.dart';

abstract class ApiProvider {
  String get baseUrl;
  Uri getUrl({String endPoint=''})=>Uri.parse(baseUrl+endPoint);
  
  fetch()async{
    try {
       Response response=await get(getUrl());
    if (response.statusCode==200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
    } catch (e) {
      throw Exception(e.toString());
    }
      
  }
}

      
    
   