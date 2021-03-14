import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

class DioInstance {
  // 实现dio的单例 此单例模式仅适用于单线程中
  static DioInstance? _instance;

  static DioInstance getInstance() {
    if (_instance == null) {
      _instance = new DioInstance();
    }
    return _instance!;
  }

  late Dio dio;
  late Dio tokenDio;
  late String csrfToken;

  // 构造函数中做一些初始化配置
  DioInstance() {
    final options = BaseOptions(
      baseUrl: "https://www.xx.com/api", // 请求的base地址,可以包含子路径
      connectTimeout: 5000, // 连接服务器超时时间，单位是毫秒
      receiveTimeout: 100000, // 2.x中为接收数据的最长时限
      // v3.0.3以下写法
      //请求的Content-Type，默认值是[ContentType.json]. 也可以用ContentType.parse("application/x-www-form-urlencoded")
      // contentType: ContentType.json,
      // contentType: ContentType.parse("application/x-www-form-urlencoded"),
      // v3.0.3以上写法 https://github.com/flutterchina/dio/issues/512
      // contentType: Headers.formUrlEncodedContentType,
      contentType: Headers.jsonContentType,
      //表示期望以那种格式(方式)接受响应数据。接受4种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
      responseType: ResponseType.json,
    );

    dio = new Dio(options);
    tokenDio = new Dio(options);

    // Cookie管理
    dio.interceptors.add(CookieManager(CookieJar()));

    // 拦截器
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      // 在请求被发送之前做一些事情
      if (options.path == "/test") {
        return dio.resolve({'name': '1111mp', 'age': 24});
      }
      print('send request：path:${options.path}，baseURL:${options.baseUrl}');
      // 给所有的请求头中添加一个csrfToken, 如果csrfToken不存在，我们先去请求csrfToken，获取到csrfToken后，再发起后续请求
      // 由于请求csrfToken的过程是异步的，我们需要在请求过程中锁定后续请求（因为它们需要csrfToken), 直到csrfToken请求成功后，再解锁
      // if (csrfToken == null) {
      //   print("no token，request token firstly...");
      //   //lock the dio.
      //   dio.lock();
      //   return tokenDio.get("/token").then((d) {
      //     options.headers["csrfToken"] = csrfToken = d.data['data']['token'];
      //     print("request token succeed, value: " + d.data['data']['token']);
      //     print(
      //         'continue to perform request：path:${options.path}，baseURL:${options.path}');
      //     return options;
      //   }).whenComplete(() => dio.unlock()); // unlock the dio
      // } else {
      //   options.headers["csrfToken"] = csrfToken;
      //   return options;
      // }
      return options;
      // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
      //
      // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    }, onResponse: (Response response) async {
      // 在返回响应数据之前做一些预处理

      return response;
    }, onError: (DioError error) async {
      // 当请求失败时做一些预处理
      // 假设当error code 401代表用户信息过期时
      // if (error.response?.statusCode == 401) {
      //   RequestOptions options = error.response.request;
      //   // If the token has been updated, repeat directly.
      //   // 如果csrfToken已经更新 配置最新的csrfToken并重新发送上一次失败的请求
      //   if (csrfToken != options.headers["csrfToken"]) {
      //     options.headers["csrfToken"] = csrfToken;
      //     // 继续发送上一次失败的请求
      //     return dio.request(options.path, options: options);
      //   }
      //   // 发起请求获取最新的csrfToken并更新
      //   // 在此之前 锁定dio以阻止新的请求 直到csrfToken更新到最新
      //   dio.lock();
      //   dio.interceptors.responseLock.lock();
      //   dio.interceptors.errorLock.lock();
      //   return tokenDio.get("/token").then((d) {
      //     // update csrfToken
      //     options.headers["csrfToken"] = csrfToken = d.data['data']['token'];
      //   }).whenComplete(() {
      //     dio.unlock();
      //     dio.interceptors.responseLock.unlock();
      //     dio.interceptors.errorLock.unlock();
      //   }).then((error) {
      //     // 继续重复发送
      //     return dio.request(options.path, options: options);
      //   });
      // }
      return error;
    }));
  }

  /*
   * @description: get请求
   * @param {string} url
   * @param {Map} <data, options, cancelToken>
   * cancelToken使用示例 CancelToken token = CancelToken(); 用于取消请求
   * @return: 
   */
  Future get(
    String url, {
    data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Response response;
    try {
      response = await dio.get(
        url,
        queryParameters: data,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioError catch (error) {
      return error;
    }
    return response.data;
  }

  /*
   * @description: post请求
   * @param {string} url
   * @param {Map} <data, options, cancelToken>
   * @return: 
   * cancelToken使用示例 CancelToken token = CancelToken(); 用于取消请求
   */
  /*
    发送 FormData:
    FormData formData = FormData.from({
      "name": "wendux",
      "age": 25,
    });
   response = await dio.post("/info", data: formData);
   */
  Future post(
    String url, {
    data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    Response response;
    try {
      response = await dio.post(
        url,
        queryParameters: data,
        onSendProgress: onSendProgress,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioError catch (error) {
      return error;
    }
    return response.data;
  }

  /*
   * @description: 下载文件
   * @param {String}} urlPath 请求url地址
   * @param {String} savePath 文件保存路径
   * 大文件的分块下载 详见：https://github.com/flutterchina/dio/blob/master/example/download.dart
   * @return: 
   */
  Future downloadFile(
    String urlPath,
    String savePath, {
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    Response response;
    try {
      response = await dio.download(
        urlPath,
        savePath,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );
    } on DioError catch (error) {
      return error;
    }
    return response.data;
  }

  /*
   * @description: 文件上传
   * @param {String} url  上传地址
   * @param {Map} data  参数
   * @param {List<File>} files  上传的文件list
   * @param {ProgressCallback} onSendProgress 上传进度的回调方法
   * 以二进制流上传formdata或文件 详见：https://github.com/flutterchina/dio/blob/master/example/post_stream_and_bytes.dart
   * @return: 
   */
  Future uploadFile(
    String url, {
    data,
    required List<File> files,
    ProgressCallback? onSendProgress,
  }) async {
    Response response;

    var uploadFiles = files.map((file) async {
      String path = file.path;
      var name = path.substring(path.lastIndexOf("/") + 1, path.length);
      return await MultipartFile.fromFile(
        path,
        filename: name,
      );
    });
    FormData formData = FormData.fromMap({
      "files": uploadFiles,
    });
    try {
      response = await dio.post(
        url,
        data: formData,
        onSendProgress: onSendProgress,
      );
    } on DioError catch (error) {
      return error;
    }
    return response.data;
  }

  /*
   * @description: 取消请求 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。所以参数可选
   * @param {CancelToken} token
   * @return: void
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }
}
