// ignore_for_file: constant_identifier_names

enum DataSource{
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORIZED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NI_INTERNET_CONNETCTION
}

class ResponseCode {
  // API status code
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTHORIZED = 401; // failure, user is not authorized
  static const int FORBIDDEN = 403; //  failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  static const int NOT_FOUND = 404; // failure, not found
  
  // local status code
  static const int UNKNOWN = -1;
  static const int CONNECT_TIMEOUT = -2;
  static const int CANCEL = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int INVALID_INPUTS = -7;
}

class ResponseMessage {
  // API status code
  static const String SUCCESS = "success "; // success with data
  static const String NO_CONTENT = "success with no data"; // success with no data (no content)
  static const String BAD_REQUEST = "Bad Request, try again later"; // failure, API rejected request
  static const String UNAUTHORIZED = "User Unauthorized,  try again later"; // failure, user is not authorized
  static const String FORBIDDEN = "Forbidden,  try again later"; //  failure, API rejected request
  static const String INTERNAL_SERVER_ERROR = "Internal Server Error, try again later"; // failure, crash in server side
  static const String NOT_FOUND = "Url Found, try again later"; // failure, not found
  
  // local status code
  static const String UNKNOWN = "Unknown error, try again later";
  static const String CONNECT_TIMEOUT = "Connection timeout, try again later";
  static const String CANCEL = "Request cancelled, try again later";
  static const String RECEIVE_TIMEOUT = "Receive timeout, try again later";
  static const String SEND_TIMEOUT = "Send timeout, try again later";
  static const String CACHE_ERROR = "Cache error, try again later";
  static const String INVALID_INPUTS = "Invalid inputs, try again later";
}
