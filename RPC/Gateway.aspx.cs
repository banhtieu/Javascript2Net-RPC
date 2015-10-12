using System;
using System.IO;
using System.Reflection;
using System.Web.Helpers;
using System.Web.UI;
using RPC.Service;

namespace RPC
{

    /// <summary>
    /// The request data
    /// </summary>
    public class RequestData
    {
        public string ServiceName { get; set; }

        public string MethodName { get; set; }

        public object[] Parameters { get; set; }

    }

    /// <summary>
    /// The response data
    /// </summary>
    public class ResponseData
    {
        public bool OK { get; set; }

        public object Data { get; set; }
    }

    /// <summary>
    /// The gateway where everything begin
    /// </summary>
    public partial class Gateway : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var inputStream = Request.InputStream;
            var reader = new StreamReader(inputStream);
            var content = reader.ReadToEnd();
            var response = new ResponseData();

            try
            {
                var data = Json.Decode<RequestData>(content);

                var result = CallService(data);

                if (data.ServiceName != null)
                {
                    response.OK = true;
                    response.Data = result;
                }
            }
            catch (Exception exception)
            {
                response.OK = false;
                response.Data = exception.Message;
            }

            Response.ContentType = "application/json; charset=utf-8";
            Response.Write(Json.Encode(response));
            Response.End();
        }


        /// <summary>
        /// Call the service and get data back
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        private object CallService(RequestData data)
        {
            var type = TypeService.GetServiceType(data.ServiceName);
            var method = type.GetMethod(data.MethodName);
            var instance = Activator.CreateInstance(type);
            return method.Invoke(instance, GetParameters(method, data.Parameters));
        }


        /// <summary>
        /// Get parameter from the input parameter
        /// </summary>
        /// <param name="method"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        private object[] GetParameters(MethodInfo method, object[] parameters)
        {
            var parameterDefinitons = method.GetParameters();
            var i = 0;

            foreach (var parameter in parameterDefinitons)
            {
                var json = Json.Encode(parameters[i]);
                parameters[i] = Json.Decode(json, parameter.ParameterType);

                i++;
            }

            return parameters;
        }
    }
}