using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web_bh.EF;

namespace Web_bh.Areas.Admin.Controllers
{
    public class SupportController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }


        [HttpPost]
        public ActionResult Index(Support model)
        {
            try
            {

                Web_bhDbcontext db = new Web_bhDbcontext();
                Support support= new Support();
                support.Phone = model.Phone;
                support.Name = model.Name;
                support.Support1 = model.Support1;
                db.Supports.Add(support);
                db.SaveChanges();
            }
            catch (Exception ex)
            {

                throw ex;
            }

            return View(model);
        }
    }
}