﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Web_bh.EF;

namespace Web_bh.Models
{
    public class CartItem
    {
        public Product Product { get; set; }
        public int Quantity { get; set; }
        public CartItem(Product product, int quantity)
        {
            Product = product;
            Quantity = quantity;
        }
    }
}