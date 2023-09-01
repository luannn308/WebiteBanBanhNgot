using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebBanBanhConnection;
namespace WebsiteCakeNew.Models.BUS
{
    public class Product_CategoryBUS
    {
        public static void AddProductCategory(PRODUCT_CATEGORY pc)
        {
            var db = new WebBanBanhConnectionDB();
            db.Insert(pc);
        }
    }
}