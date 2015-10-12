using Microsoft.VisualStudio.TestTools.UnitTesting;
using RPC.Service;

namespace RPC.Tests
{
    [TestClass]
    public class TypeServiceTest
    {

        [TestMethod]
        public void TestGetType()
        {
            Assert.AreEqual(typeof(TypeService), TypeService.GetServiceType("TypeService"));
        }


        [TestMethod]
        public void TestGetMethods()
        {
            var typeService = new TypeService();
            var methods = typeService.GetMethod("BookService");
            Assert.AreEqual(methods.Count, 2);
            Assert.AreEqual("AddBook", methods[0]);
            Assert.AreEqual("SaveBatch", methods[1]);
        }
    }
}
