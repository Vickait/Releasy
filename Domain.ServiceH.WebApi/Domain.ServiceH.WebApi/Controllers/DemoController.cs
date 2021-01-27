using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;

namespace Domain.ServiceH.WebApi.Controllers
{
    public class DemoController : ApiController
    {
        public string Get()
        {
            return "Welcome To Web API";
        }

        public List<string> Get(int Id)
        {
            return new List<string> {
                "Data1",
                "Data2",
                "Data3",
                "Data4"
            };
        }
    }
}