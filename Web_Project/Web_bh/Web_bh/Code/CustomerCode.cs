using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PagedList;
using Web_bh.EF;
namespace Web_bh.Code
{
    public class CustomerCode
    {
        Web_bhDbcontext db = null;
        public CustomerCode()
        {
            db = new Web_bhDbcontext();
        }
        public IEnumerable<Customer> ListAllPaging(string searchString, int page, int pageSize)
        {
            IQueryable<Customer> model = db.Customers;
            if (!string.IsNullOrEmpty(searchString))
            {
                model = model.Where(x => x.Name.Contains(searchString) ||
               x.Name.Contains(searchString));

            }
            return model.OrderByDescending(x => x.Id).ToPagedList(page, pageSize);
        }
    }
}