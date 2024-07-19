import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  String message = '';
  DioExceptions.fromDioError(DioException dioError, {int? statusCode}) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioExceptionType.badCertificate:
        message = "Bad Certificate in connection with API server";
        break;
      case DioExceptionType.connectionError:
        message = "Error in connection with API server";
        break;
      case DioExceptionType.unknown:
        message = httpErrorMessages[statusCode] ??
            "Unexpected error occurred while communication with API server";
      default:
        message = httpErrorMessages[statusCode] ??
            "Unexpected error occurred while communication with API server";
        break;
    }
  }

  Map<int, String> httpErrorMessages = {
    400:
        'Bad Request: The server could not understand the request due to invalid syntax.',
    401:
        'Unauthorized: The client must authenticate itself to get the requested response.',
    402: 'Payment Required: This response code is reserved for future use.',
    403: 'Forbidden: The client does not have access rights to the content.',
    404: 'Not Found: The server can not find the requested resource.',
    405:
        'Method Not Allowed: The request method is known by the server but is not supported by the target resource.',
    406:
        'Not Acceptable: The server cannot produce a response matching the list of acceptable values.',
    407:
        'Proxy Authentication Required: The client must first authenticate itself with the proxy.',
    408:
        'Request Timeout: The server would like to shut down this unused connection.',
    409:
        'Conflict: The request conflicts with the current state of the server.',
    410:
        'Gone: The content requested has been permanently deleted from the server.',
    411:
        'Length Required: The server rejected the request because the Content-Length header field is not defined.',
    412:
        'Precondition Failed: The client has indicated preconditions in its headers which the server does not meet.',
    413:
        'Payload Too Large: The request entity is larger than the server is willing or able to process.',
    414:
        'URI Too Long: The URI requested by the client is longer than the server is willing to interpret.',
    415:
        'Unsupported Media Type: The media format of the requested data is not supported by the server.',
    416:
        'Range Not Satisfiable: The range specified by the Range header field in the request cannot be fulfilled.',
    417:
        'Expectation Failed: The server cannot meet the requirements of the Expect request-header field.',
    418:
        'I\'m a teapot: The server refuses the attempt to brew coffee with a teapot.',
    421:
        'Misdirected Request: The request was directed at a server that is not able to produce a response.',
    422:
        'Unprocessable Entity: The server understands the content type of the request entity, but was unable to process the contained instructions.',
    423: 'Locked: The resource that is being accessed is locked.',
    424:
        'Failed Dependency: The request failed due to failure of a previous request.',
    425:
        'Too Early: Indicates that the server is unwilling to risk processing a request that might be replayed.',
    426: 'Upgrade Required: The client should switch to a different protocol.',
    428:
        'Precondition Required: The server requires the request to be conditional.',
    429:
        'Too Many Requests: The client has sent too many requests in a given amount of time.',
    431:
        'Request Header Fields Too Large: The server is unwilling to process the request because its header fields are too large.',
    451:
        'Unavailable For Legal Reasons: The server is denying access to the resource as a consequence of a legal demand.',
    500:
        'Internal Server Error: The server has encountered a situation it does not know how to handle.',
    501:
        'Not Implemented: The request method is not supported by the server and cannot be handled.',
    502:
        'Bad Gateway: The server, while acting as a gateway or proxy, received an invalid response from the upstream server.',
    503: 'Service Unavailable: The server is not ready to handle the request.',
    504:
        'Gateway Timeout: The server is acting as a gateway and cannot get a response in time.',
    505:
        'HTTP Version Not Supported: The HTTP version used in the request is not supported by the server.',
    506:
        'Variant Also Negotiates: The server has an internal configuration error.',
    507:
        'Insufficient Storage: The server is unable to store the representation needed to complete the request.',
    508:
        'Loop Detected: The server detected an infinite loop while processing the request.',
    510:
        'Not Extended: Further extensions to the request are required for the server to fulfill it.',
    511:
        'Network Authentication Required: The client needs to authenticate to gain network access.',
  };
}
