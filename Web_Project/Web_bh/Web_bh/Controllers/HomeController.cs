using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Web_bh.EF;
namespace Web_bh.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        Web_bhDbcontext db = new Web_bhDbcontext();
        // GET: Home
        public ActionResult Index()
        {
            return View();
        }
    }
}