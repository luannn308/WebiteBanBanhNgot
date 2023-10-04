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
        public static int CheckProductCategory(int p, int c)
        {
            var db = new WebBanBanhConnectionDB();
            int check = db.SingleOrDefault<int>("SELECT COUNT(*) FROM PRODUCT_CATEGORY WHERE ProductID = @0 AND CategoryID = @1", p, c);
            return check;
        }
        public static void DeleteCateNotIn(int p, List<int> cates)
        {
            var db = new WebBanBanhConnectionDB();
            string catesString = string.Join(",", cates);
            db.Execute("DELETE FROM Product_Category WHERE ProductID = @0 AND CategoryID NOT IN (" + catesString + ")", p);
        }
        public static void DeleteCate(int p)
        {
            var db = new WebBanBanhConnectionDB();
            db.Execute("DELETE FROM Product_Category WHERE ProductID = @0", p);
        }
    }
}