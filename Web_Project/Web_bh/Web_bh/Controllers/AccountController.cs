using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Web_bh.Code;
using Web_bh.EF;
using WebMatrix.WebData;
using System.Data.Entity.Migrations;
using System.Net.Mail;

namespace Web_bh.Controllers
{
    public class AccountController : Controller
    {
        Web_bhDbcontext db = new Web_bhDbcontext();
        // GET: Account
        public ActionResult Index()
        {
            return View();
        }
        //Edit
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Customer customer = db.Customers.Find(id);
            if (customer == null)
            {
                return HttpNotFound();
            }
            return View(customer);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,Name,BirthDay,Address,Tel,Email,Password")] Customer customer)
        {
            if (ModelState.IsValid)
            {
                db.Entry(customer).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index","Home");
            }
            return View(customer);
        }
        //Register
        public bool CheckEmail(string Email)
        {
            return db.Customers.Count(x => x.Email == Email) > 0;
        }
        public ActionResult Register()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Register([Bind(Include = "Id,Name,BirthDay,Address,Tel,Email,Password")] Customer customer)
        {
            if (ModelState.IsValid)
            {
                
                if(CheckEmail(customer.Email))
                {
                    ModelState.AddModelError("", "Email đã tồn tại");
                }
                else
                {
                    db.Customers.Add(customer);
                    db.SaveChanges();
                    return RedirectToAction("Login", "Account");
                    
                }
                
            }

            return View(customer);
        }
        //Login
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(Customer model)
        {
            Session["cus"] = "";
            Session["cus_id"] = "";
            Session["cus_Name"] = null;
            Session["cus_Email"] = null;
            Session["cus_Password"] = "";

            if (ModelState.IsValid)
            {
                //model.Password = Encryptor.MD5Hash(model.Password);
                if (!db.Customers.Where(m => m.Email == model.Email).Count().Equals(0))
                {
                    if (!db.Customers.Where(m => m.Email == model.Email && m.Password == model.Password).Count().Equals(0))
                    {
                        var user_login = db.Customers.Where(m => m.Email == model.Email && m.Password == model.Password).First();

                        Session["cus"] = 1;
                        Session["cus_id"] = user_login.Id;
                        Session["cus_Name"] = user_login.Name;
                        Session["cus_Email"] = user_login.Email;
                        Session["cus_Password"] = user_login.Password;

                        return RedirectToAction("Index", "Home");
                    }
                    else
                    {
                        ModelState.AddModelError("", "Mật khẩu không chính xác");
                        //ViewBag.Message = "Mật khẩu không chính xác";
                    }
                }
                else
                {
                    ModelState.AddModelError("", "Email không tồn tại");
                    //ViewBag.Message = "Tên tài khoản không tồn tại";
                }
            }
            else
            {
                ModelState.AddModelError("", "Thông tin không chính xác");
                //ViewBag.Messgae = "Thông tin không chính xác";
            }
            return View();
        }
        public ActionResult ChangePassword()
        {
            return View();
        }
        [HttpPost]
        public ActionResult ChangePassword(string newpass, string conf)
        {
            if (Session["cus_id"].Equals(""))
            {
                return RedirectToAction("Login");
            }
            Customer cus = db.Customers.Find(Session["cus_id"]);

            if(cus.Password != newpass)
            {
                if(newpass == conf)
                {
                    cus.Password = newpass;
                    db.SaveChanges();
                    return RedirectToAction("Index", "Home");
                }
                else
                {
                    ModelState.AddModelError("", "Confirm Password sai");
                }
            }
            else
            {
                ModelState.AddModelError("", "Password không thay đổi");
            }
            return View();
        }
        public ActionResult Logout(Customer model)
        {
            Session.Abandon();
            Session.Clear();

            return RedirectToAction("Index", "Home");
        }
        //Forgot password
        [AllowAnonymous]
        public ActionResult Forgot()
        {
            return View();
        }
        [AllowAnonymous, HttpPost]
        public ActionResult Forgot(String Email)
        {
            var cust = db.Customers.Where(x => x.Email == Email).ToString();
            if (!db.Customers.Where(m => m.Email == Email).Count().Equals(0))
            {
                string TokenCode = Guid.NewGuid().ToString();
                Customer customer = db.Customers.Where(x => x.Email == Email).First();
                customer.Password = TokenCode;
                db.SaveChanges();
                Send(Email, "Your Password has been reset", TokenCode);
                return View("Reset");
            }
            else
            {
                ModelState.AddModelError("", "Email không tồn tại !");
                return View();
            }
        }
        public static void Send(String to, String subject, String body)
        {
            var from = "MD Shop <uongquangminh1803@gmail.com> ";
            var message = new MailMessage();
            message.IsBodyHtml = true;
            message.From = new MailAddress(from);
            message.To.Add(new MailAddress(to));
            message.Subject = subject;
            message.Body = "Your password: " + body;
            var client = new SmtpClient("smtp.gmail.com", 587)
            {
                Credentials = new NetworkCredential("uongquangminh1803@gmail.com", "Qminh000000"),
                EnableSsl = true
            };
            // Gởi mail
            client.Send(message);
        }
        [AllowAnonymous, HttpPost]
        public ActionResult Reset(String Email, String TokenCode, String NewPassword)
        {
            var cust = db.Customers
                    .Single(c => c.Email == Email && c.Password == TokenCode);

            var user = db.Customers.Find(cust.Id);
            user.Password = NewPassword;
            db.SaveChanges();
            return RedirectToAction("Login");
        }

    }
}