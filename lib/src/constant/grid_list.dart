// import 'package:oms_salesforce/src/constant/asstes_list.dart';
// import 'package:oms_salesforce/src/enum/enumerator.dart';

// class GridList {
//   static List<dynamic> indexGridList = [
//     ["Add Leave", HomePageGridEnum.addLeave, AssetsList.leaveNotes],
//     ["Quick Order", HomePageGridEnum.quickOrder, AssetsList.quickOrder],
//     ["Smart Order", HomePageGridEnum.smartOrder, AssetsList.smartOrder],
//     ["Pending Sync", HomePageGridEnum.pendingSync, AssetsList.pendingSync],
//     [
//       "Pending Verify",
//       HomePageGridEnum.pendingVerify,
//       AssetsList.pendingVerified
//     ],
//     [
//       "Target And Achivement",
//       HomePageGridEnum.targetAndAchivement,
//       AssetsList.targetIcon
//     ],
//     [
//       "Coverage And Productivity",
//       HomePageGridEnum.coverageAndProductivity,
//       AssetsList.productivityIcon
//     ],
//     [
//       "Delivered Report",
//       HomePageGridEnum.deliveredReport,
//       AssetsList.deliveredReport
//     ],
//     ["Order Report", HomePageGridEnum.orderReport, AssetsList.orderReport],
//     ["Movement GPS", HomePageGridEnum.movementGps, AssetsList.movementGPS],
//     ["Activity GPS", HomePageGridEnum.activityGps, AssetsList.activityGPS],
//   ];

//   ///
//   static List<dynamic> getFilteredGridList({
//     required bool isShow,
//     required int removeIndex,
//   }) {
//     if (isShow) {
//       return indexGridList;
//     } else {
//       List<dynamic> filteredList = List.from(indexGridList);
//       // Remove the item at removeIndex if it's a valid index
//       if (removeIndex >= 0 && removeIndex < filteredList.length) {
//         filteredList.removeAt(removeIndex);
//       }
//       return filteredList;
//     }
//   }
// }
