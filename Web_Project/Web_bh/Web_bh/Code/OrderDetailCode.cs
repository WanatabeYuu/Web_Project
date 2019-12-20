using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Web_bh.EF;

namespace Web_bh.Code
{
    public class OrderDetailCode
    {
        Web_bhDbcontext db = null;
        public OrderDetailCode()
        {
            db = new Web_bhDbcontext();
        }
        public bool Insert(OrderDetail detail)
        {
            try
            {
                db.OrderDetails.Add(detail);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;

            }
        }
    }
}