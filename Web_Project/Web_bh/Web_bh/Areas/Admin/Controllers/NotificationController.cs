using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Web_bh.EF;

namespace Web_bh.Areas.Admin.Controllers
{
    public class NotificationController : Controller
    {
        Web_bhDbcontext db = new Web_bhDbcontext();
        // GET: Admin/Notification
        public ActionResult Index()
        {
            return View(db.Supports.ToList());
        }
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Support support = db.Supports.Find(id);
            if (support == null)
            {
                return HttpNotFound();
            }
            return View(support);
        }

        // POST: Admin/Notification/Delete/5
          [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Support support = db.Supports.Find(id);
            db.Supports.Remove(support);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
    }
    
}
