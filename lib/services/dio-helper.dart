import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static init() {                  
    dio = Dio(
    BaseOptions(
      receiveDataWhenStatusError: true ,
      followRedirects: false,    
      validateStatus: (status) => true,
      headers: {
      'Content-Type': 'application/json',
      }
    )
    );
  }

  static Future<Response> fecthData({
    required String url,
     String? token ,
     Map<String,dynamic> ?data,
     Map<String, dynamic>? query,
    })async{
    dio.options.headers = {
      'Authorization': token ?? '',
    };
        return await dio.get(url,data: data ,queryParameters: query);
       
  }
  
  static Future<Response>postData({
   required  String url,
   required Map<String,dynamic> data,
    Map<String, dynamic>? query,
    })async{
     return await dio.post(
      url,
     data: data,
     queryParameters: query
     );
  } 

  static Future<Response>putData({
     String? url,
     Map<String,dynamic> ?data,
    })async{
    return  await dio.put(url!,data: data);
  } 

 static Future<Response>deleteData({
    required String url,
     Map<String,dynamic> ?data,
     Map<String, dynamic>? query,
    })async{
    return await dio.delete(url,data: data,queryParameters: query);
  }   




}
