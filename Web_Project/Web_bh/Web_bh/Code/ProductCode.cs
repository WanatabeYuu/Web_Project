using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PagedList;
using Web_bh.EF;
namespace Web_bh.Code
{
    public class ProductCode
    {
        Web_bhDbcontext db = null;
        public ProductCode()
        {
            db = new Web_bhDbcontext();
        }
        public List<Product> ListNewProduct(int top)
        {
            return db.Products.OrderByDescending(x => x.Date).Take(top).ToList();
        }
        public IEnumerable<Product> ListAllPaging(int page, int pageSize)
        {
            IQueryable<Product> model = db.Products;
            return db.Products.OrderByDescending(x => x.Id).ToPagedList(page,pageSize);
        }

        public List<Product> ListProduct()
        {
            return db.Products.Where(x => x.Status == true).ToList();
        }
        public List<Product> ListRelatedProducts(long productId)
        {
            var product = db.Products.Find(productId);
            return db.Products.Where(x => x.Id != productId && x.Group_Product == product.Group_Product).ToList();
        }
        public List<Product> ListHotDealProduct(int top)
        {
            return db.Products.Where(x => x.Hotdeal != null && x.Date > DateTime.Now).OrderByDescending(x => x.Id).Take(top).ToList();
        }

        public Product ViewDetail(long id)
        {
            return db.Products.Find(id);
        }
    }
}