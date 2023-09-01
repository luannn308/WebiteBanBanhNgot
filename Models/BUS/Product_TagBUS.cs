using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebBanBanhConnection;

namespace WebsiteCakeNew.Models.BUS
{
    public class Product_TagBUS
    {
        public static void AddProductTag(PRODUCT_TAG pt)
        {
            var db = new WebBanBanhConnectionDB();
            db.Insert(pt);
        }
    }
}