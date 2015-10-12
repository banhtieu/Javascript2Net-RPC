<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Angular.aspx.cs" Inherits="RPC.Angular" %>

<!DOCTYPE html>

<html data-ng-app="AngularSample" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Remote Sample</title>

    <script src="Scripts/jquery-2.1.4.min.js"></script>
    <script src="Scripts/jquery.remote.js"></script>
    <!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.1/css/materialize.min.css"/>

    <!-- Compiled and minified JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.1/js/materialize.min.js"></script>

    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/highlight.js/8.8.0/styles/default.min.css"/>
    <script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/8.8.0/highlight.min.js"></script>
    <script>hljs.initHighlightingOnLoad();</script>
    
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.5/angular.min.js"></script>
    <script>
        // put angularjs source here for example
        var application = angular.module("AngularSample", []);

        // define the service
        application.factory("$bookmarkService", function() {
            return $.remoteObject("BookmarkService");
        });

        // define the controller
        application.controller("BookmarkController", [
            "$scope", "$bookmarkService", function($scope, $bookmarkService) {
                
                $scope.loadData = function() {
                    $bookmarkService.GetAll().then(function (data) {
                        $scope.bookmarks = data;
                        $scope.$apply();
                    });
                }

                $scope.save = function () {
                    $bookmarkService.Save($scope.bookmark)
                        .then($scope.loadData);
                }

                $scope.delete = function () {
                    $bookmarkService.Delete($scope.bookmark.Id)
                        .then($scope.loadData);
                }

                // select item
                $scope.selectItem = function(item) {
                    $scope.bookmark = item;
                }

                $bookmarkService.ready(function () {
                    $scope.loadData();
                });

            }]);
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div data-ng-controller="BookmarkController" class="container">
        <div class="card row">
            <div class="col s3">
                <div class="container">
                    <ul class="collection">
                        <li class="collection-item" data-ng-repeat="bookmark in bookmarks" style="padding: 0; margin: 0">
                            <a data-ng-click="selectItem(bookmark)" data-ng-href="#" class="waves-effect waves-teal" style="display: block; padding: 5px 10px;">
                                {{ bookmark.Name }}
                            </a>
                        </li>
                    </ul>
                    <a data-ng-click="selectItem({})" class="waves-effect waves-light btn">Add</a>
                </div>
            </div>

            <div class="col s9">
                <div class="row">
                    <div class="col s12">
                        <div class="row">
                            <div class="input-field col s12">
                                <input data-ng-model="bookmark.Name" placeholder="name of the bookmark" id="name" type="text" class="validate"/>
                                <label for="name">Name</label>
                            </div>
                        </div>
                    </div>
                    <div class="col s12">
                        <div class="row">
                            <div class="input-field col s12">
                                <input data-ng-model="bookmark.URL" placeholder="url of the bookmark" id="url" type="text" class="validate"/>
                                <label for="url">URL</label>
                            </div>
                        </div>
                    </div>
                    <div class="col s12">
                        <div class="row">
                            <a data-ng-click="save()" class="waves-effect waves-light btn">Save</a>
                            <a data-ng-click="delete()" data-ng-show="bookmark.Id" class="waves-effect waves-light btn">Delete</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="card row">
            <div class="card-content white-text">
                            <span class="card-title"  style="color: black">Angular Code</span>
                            <pre>
<code class="JavaScript">// put angularjs source here for example
var application = angular.module("AngularSample", []);

// define the service
application.factory("$bookmarkService", function() {
    return $.remoteObject("BookmarkService");
});

// define the controller
application.controller("BookmarkController", [
"$scope", "$bookmarkService", function($scope, $bookmarkService) {
                
    $scope.loadData = function() {
        $bookmarkService.GetAll().then(function (data) {
            $scope.bookmarks = data;
            $scope.$apply();
        });
    }

    $scope.save = function () {
        $bookmarkService.Save($scope.bookmark)
            .then($scope.loadData);
    }

    $scope.delete = function () {
        $bookmarkService.Delete($scope.bookmark.Id)
            .then($scope.loadData);
    }

    // select item
    $scope.selectItem = function(item) {
        $scope.bookmark = item;
    }

    $bookmarkService.ready(function () {
        $scope.loadData();
    });

}]);
</code>
                            </pre>
                        </div>
        </div>
    </div>
    </form>
</body>
</html>
