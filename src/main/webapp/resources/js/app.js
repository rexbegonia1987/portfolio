
var dicList = [
{eng:'start', kor:'시작'},
{eng:'end', kor:'끝'}
];
 
/**
 * controller
 */
var app = angular.module('dicApp', []);
app.controller('dicCtrl', function($scope) {
    $scope.appName = "DIC APP";
    $scope.dicList = dicList;
    $scope.changeSection = function(){
    	alert($scope.about);
    }
});