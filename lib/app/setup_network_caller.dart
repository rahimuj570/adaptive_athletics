import 'package:newproject/app/services/network_caller_service.dart';

NetworkCallerService getNetworkCaller({Map<String, String>? header}) {
  final defaultHeaders = {'Content-Type': 'application/json'};

  final effectiveHeader = {...defaultHeaders, ...?header};

  return NetworkCallerService(headers: effectiveHeader);
}
