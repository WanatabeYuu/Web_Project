using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web_bh.EF;
using Web_bh.Models;

namespace Web_bh.Areas.Admin.Controllers
{
    public class DashboardController : Controller
    {
        Web_bhDbcontext db = new Web_bhDbcontext();
        // GET: Admin/Dashboard
        public ActionResult Index()
        {
            if (Session["user_admin"].Equals(""))
            {
                return RedirectToAction("Login", "Dashboard");
            }
            return View();
        }
        public ActionResult Login(User model)
        {
            Session["user_admin"] = "";
            Session["user_id"] = "";
            Session["user_name"] = "";
            Session["user_username"] = "";
            Session["user_password"] = "";
            Session["user_rule"] = "";
            Session["user_status"] = "";

            ViewBag.Message = "";
            if (ModelState.IsValid)
            {
                //model.Password = encty.MD5(model.Password);
                if (!db.Users.Where(m => m.UserName == model.UserName).Count().Equals(0))
                {
                    if (!db.Users.Where(m => m.UserName == model.UserName && m.Password == model.Password).Count().Equals(0))
                    {
                        var user_login = db.Users.Where(m => m.UserName == model.UserName && m.Password == model.Password).First();
                        Session["user_admin"] = 1;
                        Session["user_id"] = user_login.Id;
                        Session["user_name"] = user_login.Name;
                        Session["user_username"] = user_login.UserName;
                        Session["user_password"] = user_login.Password;
                        Session["user_rule"] = user_login.Rule;
                        Session["user_status"] = user_login.Status;

                        return RedirectToAction("Index", "Dashboard");
                    }
                    else
                    {
                        ModelState.AddModelError("", "Mật khẩu không chính xác");
                        //ViewBag.Message = "Mật khẩu không chính xác";
                    }
                }
                else
                {
                    ModelState.AddModelError("", "Tên tài khoản không tồn tại");
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
        public ActionResult Logout(User model)
        {
            Session["user_admin"] = "";
            Session["user_id"] = "";
            Session["user_name"] = "";
            Session["user_username"] = "";
            Session["user_password"] = "";
            Session["user_rule"] = "";
            Session["user_status"] = "";
            return RedirectToAction("Index", "Dashboard");
        }
        public ActionResult ThongKeTheoNam()
        {
            string query = "SELECT YEAR(Dates) as Nam, sum(Price) as Tong "
        + "FROM OrderDetail "
        + "GROUP BY Year(Dates)";
            IEnumerable<ThongKeTheoNam> data = db.Database.SqlQuery<ThongKeTheoNam>(query);

            return View(data.ToList());
        }

        public ActionResult ThongKeTheoThang(int? nam)
        {
            if(nam == null)
            {
                string query = "SELECT month(Dates) as Thang,sum(Price) as Tong "
        + "FROM OrderDetail "
        + "where YEAR(Dates) = " + 2018 + " "
        + "GROUP BY month(Dates)";
                IEnumerable<ThongKeTheoThang> data = db.Database.SqlQuery<ThongKeTheoThang>(query);

                return View(data.ToList());
            }
            else
            {
                string query = "SELECT month(Dates) as Thang,sum(Price) as Tong "
        + "FROM OrderDetail "
        + "where YEAR(Dates) = " + nam + " "
        + "GROUP BY month(Dates)";
                IEnumerable<ThongKeTheoThang> data = db.Database.SqlQuery<ThongKeTheoThang>(query);

                return View(data.ToList());
            }
            
        }

    }
}