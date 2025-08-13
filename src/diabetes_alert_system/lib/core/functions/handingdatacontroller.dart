
import '../class/statusrequest.dart';

handlingData(response){
  if (response is StatusRequest){
    return response ;
  }else {
    return StatusRequest.success ;
  }
}


// import 'package:vans/core/class/statusrequest.dart';
//
// StatusRequest handlingData(dynamic response) {
//   // Print type for debug
//   print("handlingData: response type is ${response.runtimeType}");
//
//   // If it's exactly a StatusRequest enum, return it (error cases)
//   if (response is StatusRequest) {
//     return response;
//   }
//
//   // For Map or any map-like object with 'status' key
//   if (response is Map && response.containsKey("status")) {
//     // Optionally check status value for more granularity
//     if (response["status"] == "success") {
//       return StatusRequest.success;
//     } else if (response["status"] == "failure") {
//       return StatusRequest.failure;
//     }
//     // Add other status keys as needed
//     return StatusRequest.success; // Default for known map with 'status'
//   }
//
//   // For web: sometimes Map interop fails, so use toString() check
//   if (response.toString().contains("status: success") ||
//       response.toString().contains("status: failure")) {
//     if (response.toString().contains("status: success")) {
//       return StatusRequest.success;
//     } else {
//       return StatusRequest.failure;
//     }
//   }
//
//   // All other cases are unexpected
//   return StatusRequest.serverException;
// }