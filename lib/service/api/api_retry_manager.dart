class ApiRetryManager {
  final List<Function> _pendingRequests = [];

  void addRequest(Function request) {
    _pendingRequests.add(request);
  }

  void retryPending() {
    for (final request in List.from(_pendingRequests)) {
      request();
      _pendingRequests.remove(request);
    }
  }
}

final apiRetryManager = ApiRetryManager();
