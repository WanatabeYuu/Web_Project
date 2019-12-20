using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Web_bh.EF;
namespace Web_bh.Code
{
    public class OrderCode
    {
        Web_bhDbcontext db = null;
        public OrderCode()
        {
            db = new Web_bhDbcontext();
        }
        public long Insert(Order order)
        {
            db.Orders.Add(order);
            db.SaveChanges();
            return order.Id;
        }

        internal object Insert(OrderCode order)
        {
            throw new NotImplementedException();
        }
    }
}