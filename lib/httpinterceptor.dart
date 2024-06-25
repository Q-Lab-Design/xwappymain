import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:universal_html/html.dart' as html;
import 'package:xwappy/constants.dart';

final httpi = InterceptedHttp.build(interceptors: [
  MyHttpInterceptor(),
], retryPolicy: TooManyRequestRetryPolicy());

class MyHttpInterceptor implements InterceptorContract {
  Future<bool> getSubDomain({domainname}) async {
    var body = jsonEncode({"domain_name": domainname});
    try {
      final response = await httpi.post(
        Uri.parse("${Constants.baseUrl}/XwapyMobile/GetSubDomain"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Constants.store.read("TOKEN")}",
        },
        body: body,
      );

      isgetDomainLogicCalled = true;

      // Constants.logger.d(response.request?.url);
      var resData = jsonDecode(response.body);

      Constants.logger.d(resData);
      if (response.statusCode != 200) {
        return false;
      } else {
        Constants.subdomain = resData['data']['sub_domain'];
        return true;
      }
    } catch (error) {
      Constants.logger.d(error);

      return false;
    }
  }

  Future runGetSubdomainLogic() async {
    String url = html.window.location.href.toString();

    Uri uri = Uri.parse(url);

    String host = uri.host;
    Constants.domain = host;

    Constants.logger.d('runGetSubdomainLogict');
    Constants.logger.d(html.window.location.href);
    Constants.logger.d(uri.host);

    if (host.toLowerCase().contains("xwapy.com")) {
      Constants.subdomain = host.split('.').first.toString();

      if (host.split('.').length > 1) {
        Constants.domain = host.split('.')[1];
      }
    } else {
      // isgetDomainLogicCalled = false;
      return await getSubDomain(domainname: host).then((onValue) {
        Constants.logger.d(Constants.subdomain);
      });
    }
  }

  @override
  Future<bool> shouldInterceptRequest() {
    return Future.value(true);
  }

  @override
  Future<bool> shouldInterceptResponse() {
    return Future.value(false);
  }

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    return Future.value(response);
  }

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    if (isgetDomainLogicCalled == false) {
      // isgetDomainLogicCalled = true;
      // Constants.logger.d("getDomainLogicCalled false");
      // await runGetSubdomainLogic();
      return Future.value(request);
    } else {
      Constants.logger.d("getDomainLogicCalled true");
      return Future.value(request);
    }
  }
}

class TooManyRequestRetryPolicy extends RetryPolicy {
  @override
  Future<bool> shouldAttemptRetryOnResponse(response) async {
    if (response.statusCode == 429) {
      Constants.logger.d("Retrying this request ${response.request!.url} ");
      await Future.delayed(const Duration(seconds: 3));
      return true;
    }

    return false;
  }
}
