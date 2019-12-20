using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Web_bh.EF;

using Web_bh.Code;
namespace Web_bh.Controllers
{
    public class ProductController : Controller
    {
        Web_bhDbcontext db = new Web_bhDbcontext();
        // GET: Product
        public ActionResult Index()
        {
            return View(db.Products.ToList());
        }
        public ActionResult Detail(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }

            // Lấy cookie cũ tên views
            var views = Request.Cookies["views"];
            // Nếu chưa có cookie cũ -> tạo mới
            if (views == null)
            {
                views = new HttpCookie("views");
            }
            // Bổ sung mặt hàng đã xem vào cookie
            views.Values[id.ToString()] = id.ToString();
            // Đặt thời hạn tồn tại của cookie
            views.Expires = DateTime.Now.AddMonths(1);
            // Gửi cookie về client để lưu lại
            Response.Cookies.Add(views);

            // Lấy List<int> chứa mã hàng đã xem từ cookie
            var keys = views.Values
                .AllKeys.Select(k => int.Parse(k)).ToList();
            // Truy vấn háng đãn xem
            ViewBag.Views = db.Products
                .Where(p => keys.Contains(p.Id));
            return View(product);
        }
        public ActionResult NewProduct(/*int? id*/)
        {
            //if (id == null)
            //{
            //    return View(db.Products.Where(x=>x.Group_Product==1).OrderByDescending(x => x.Date).Take(5).ToList());
            //}
            //else
            //{
            //    List<Product> pro = db.Products.Where(x => x.Group_Product == id).ToList();

            //    return View(pro.OrderByDescending(x => x.Date).Take(6).ToList());
            //}
            return View(db.Products.ToList());
        }

        public ActionResult Store(string searchString, int? groupid)
        {
            if (!String.IsNullOrEmpty(searchString))
            {
                if(groupid == null)
                {
                    return View(db.Products.Where(x => x.Name.Contains(searchString)).ToList());
                }
                else
                {
                    return View(db.Products.Where(x => x.Name.Contains(searchString) & x.Group_Product == groupid).ToList());
                }
            }
            else
            {
                if(groupid == null)
                {
                    return View(db.Products.ToList());
                }
                else
                {
                    return View(db.Products.Where(x => x.Group_Product == groupid).ToList());
                }
            }
        }
        public ActionResult HotDeal()
        {
            return View(db.Products.ToList());
        }
        public ActionResult TopSell()
        {
            return View(db.Products.ToList());
        }
        public List<Product> Laptop()
        {
            return db.Products.Where(x => x.Group_Product == 1).ToList();
        }
        public ActionResult ListLaptop()
        {
            return View(Laptop());
        }
        public ActionResult checkbox(int? groupid)
        {
            if (groupid == null)
            {
                return View(db.Products.ToList());
            };
            if (groupid == 1)
            {
                return View(db.Products.Where(x => x.Group_Product == 1).ToList());
            };
            if (groupid == 2)
            {
                return View(db.Products.Where(x => x.Group_Product == 2).ToList());
            };
            if (groupid == 3)
            {
                return View(db.Products.Where(x => x.Group_Product == 2).ToList());
            };
            if (groupid == 4)
            {
                return View(db.Products.Where(x => x.Group_Product == 2).ToList());
            };

            return View("Store");
        }
    }
}