using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;

namespace Domain.ServiceH.WebApi.Controllers
{
    public class HealthController : ApiController
    {
        [Route("health/version")]
        [AcceptVerbs("GET", "POST")]
        public IHttpActionResult Version()
        {
            string version = Assembly.GetExecutingAssembly().GetName().Version.ToString();
            return Ok(version);
        }

        [Route("health/selftest")]
        [AcceptVerbs("GET", "POST")]
        public async Task<IHttpActionResult> Selftest()
        {
            string healthStatus = "Service is up and Running";
            return Ok(healthStatus);
        }
    }
}