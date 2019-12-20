using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace Web_bh
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            RouteConfig.RegisterRoutes(RouteTable.Routes);
        }
        protected void Session_Start()
        {
            Session["cus"] = "";
            Session["cus_id"] = "";
            Session["cus_Name"] = null;
            Session["cus_Email"] = null;
            Session["cus_Password"] = "";

            Session["user_admin"] = "";
            Session["user_id"] = "";
            Session["user_name"] = "";
            Session["user_username"] = "";
            Session["user_password"] = "";
            Session["user_rule"] = "";
            Session["user_status"] = "";

            Session["Cart"] = null;
        }
    }
}
