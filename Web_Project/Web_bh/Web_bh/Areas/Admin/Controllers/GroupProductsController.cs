using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Web_bh.EF;

namespace Web_bh.Areas.Admin.Controllers
{
    public class GroupProductsController : Controller
    {
        private Web_bhDbcontext db = new Web_bhDbcontext();

        // GET: Admin/GroupProducts
        public ActionResult Index()
        {
            return View(db.GroupProducts.ToList());
        }

        // GET: Admin/GroupProducts/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            GroupProduct groupProduct = db.GroupProducts.Find(id);
            if (groupProduct == null)
            {
                return HttpNotFound();
            }
            return View(groupProduct);
        }

        // GET: Admin/GroupProducts/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Admin/GroupProducts/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,Name")] GroupProduct groupProduct)
        {
            if (ModelState.IsValid)
            {
                db.GroupProducts.Add(groupProduct);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(groupProduct);
        }

        // GET: Admin/GroupProducts/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            GroupProduct groupProduct = db.GroupProducts.Find(id);
            if (groupProduct == null)
            {
                return HttpNotFound();
            }
            return View(groupProduct);
        }

        // POST: Admin/GroupProducts/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,Name")] GroupProduct groupProduct)
        {
            if (ModelState.IsValid)
            {
                db.Entry(groupProduct).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(groupProduct);
        }

        // GET: Admin/GroupProducts/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            GroupProduct groupProduct = db.GroupProducts.Find(id);
            if (groupProduct == null)
            {
                return HttpNotFound();
            }
            return View(groupProduct);
        }

        // POST: Admin/GroupProducts/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            GroupProduct groupProduct = db.GroupProducts.Find(id);
            db.GroupProducts.Remove(groupProduct);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
