using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using Web_bh.Code;
using Web_bh.EF;
using Web_bh.Models;

namespace Web_bh.Controllers
{
    public class CartController : Controller
    {
        Web_bhDbcontext db = new Web_bhDbcontext();

        // GET: Cart
        public ActionResult Index()
        {
            if (Session["cus_id"].Equals(""))
            {
                return RedirectToAction("Login", "Account");
            }
            if (Session["Cart"]==null)
            {
                return View("CartEmpty");
            }
            return View();
        }
        public ActionResult CartEmpty()
        {
            return View();
        }
        public ActionResult Success()
        {
            return View();
        }
        public ActionResult OrderNow(int? id)
        {
            if (Session["cus_id"].Equals(""))
            {
                return RedirectToAction("Login", "Account");
            }

            if (Session["Cart"] == null)
            {
                List<CartItem> lscard = new List<CartItem>
                {
                    new CartItem(db.Products.Find(id),1)
                };
                Session["Cart"] = lscard;
            }
            else
            {
                List<CartItem> lscard = (List<CartItem>)Session["Cart"];
                int check = isExisting(id);
                if (check == -1)
                    lscard.Add(new CartItem(db.Products.Find(id), 1));
                else
                    lscard[check].Quantity += 1;
                Session["Cart"] = lscard;
            }
            return RedirectToAction("Index","Cart");
        }
        private int isExisting (int? id)
        {
            List<CartItem> cart = (List<CartItem>)Session["Cart"];
            for(int i=0;i<cart.Count;i++)
            {
                if (cart[i].Product.Id == id) return i;
            }
            return -1;
        }
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            int check = isExisting(id);

            List<CartItem> cart = (List<CartItem>)Session["Cart"];
            cart.RemoveAt(check);
            return View("Index");
        }
        public ActionResult DeleteAll()
        {
            Session["Cart"] = null;
            return View();
        }
        public List<CartItem> ListCart()
        {
            if (Session["Cart"] == null)
            {
                List<CartItem> lscard = new List<CartItem>();
                Session["Cart"] = lscard;
            }
            List<CartItem> cart = (List<CartItem>)Session["Cart"];
            return cart;
        }
        public ActionResult YourCart()
        {
            return View(ListCart());
        }
        [HttpGet]
        public ActionResult CheckOut()
        {
            var cart = Session["Cart"];
            var list = new List<CartItem>();
            if (cart != null)
            {
                list = (List<CartItem>)cart;
            }
            else
            {
                return View("CartEmpty");
            }
            return View(list);
        }
        [HttpPost]
        public ActionResult CheckOut(string address, string tel)
        {
            Customer cus = db.Customers.Find(Session["cus_id"]);

            List<CartItem> lscart = (List<CartItem>)Session["Cart"];

            Order order = new Order();
            order.Customer_Id = cus.Id;
            order.Status = true;
            order.shipAdress = address;
            order.shipTel = tel;
            db.Orders.Add(order);

            db.SaveChanges();

            foreach (CartItem item in lscart)
            {
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.Product_Id = item.Product.Id;
                orderDetail.Order_Id = order.Id;
                orderDetail.Price = item.Product.PriceNew;
                orderDetail.Quantity = item.Quantity;
                orderDetail.Dates = DateTime.Now;
                db.OrderDetails.Add(orderDetail);

                Product product = db.Products.Find(item.Product.Id);
                product.Sold++;
                db.SaveChanges();
            }
            Session["Cart"] = null;
            return View("Success");

        }
    }
}