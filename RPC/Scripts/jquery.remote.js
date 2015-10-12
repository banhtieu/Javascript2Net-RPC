(function ($) {

    var endPoint = "/Gateway.aspx";

    function callRemoteService(service, method, parameters) {
        var request = $.ajax({
            url: endPoint,
            type: "POST",
            data: JSON.stringify({
                "ServiceName": service,
                "MethodName": method,
                "Parameters": parameters
            }),
            dataType: "json"
        });

        /// then method
        request.then = function (handler) {
            request.handler = handler;
        }

        /// done
        request.done(function(data) {
            if (data["OK"]) {
                if (request.handler != null) {
                    request.handler(data["Data"]);
                }
            }
        });

        return request;
    }

    $.remoteObject = function (name) {
        var object = {
            '_call': callRemoteService,
            '_name': name
        };

        callRemoteService("TypeService", "GetMethod", [name])
            .then(function(methods) {
                for (var i = 0; i < methods.length; i++) {
                    var method = methods[i];
                    eval("object[method] = function () {\n"
                        + "arguments.toJSON = [].slice;\n"
                        + "return this._call(this._name, \"" + method + "\", arguments);\n"
                        + "}\n");
                }

                if (object.onload) {
                    object.onload();
                }

                object.isReady = true;
            });

        object.ready = function (onload) {
            this.onload = onload;

            if (this.isReady) {
                this.onload();
            }
        }

        return object;
    }

})(jQuery);