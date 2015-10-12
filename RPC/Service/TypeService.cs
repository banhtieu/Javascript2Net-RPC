using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;

namespace RPC.Service
{

    [RemoteService]
    public class TypeService
    {

        /// <summary>
        /// Return list of method for a class name
        /// </summary>
        /// <param name="serviceName"></param>
        /// <returns></returns>
        [RemoteMethod]
        public List<string> GetMethod(string serviceName)
        {
            var serviceType = GetServiceType(serviceName);
            var methods = serviceType.GetMethods(BindingFlags.Instance | BindingFlags.Public);
            var result = methods
                .Where(method => method.GetCustomAttributes(typeof(RemoteMethodAttribute)).Any())
                .Select(method => method.Name).ToList();
            return result;
        }


        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public static Type GetServiceType(string serviceName)
        {
            return Type.GetType("RPC.Service." + serviceName, true);
        }
    }


}