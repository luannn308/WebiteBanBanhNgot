using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
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
        public static int CheckProductTag(int p, int t)
        {
            var db = new WebBanBanhConnectionDB();
            int check = db.SingleOrDefault<int>("SELECT COUNT(*) FROM PRODUCT_TAG WHERE ProductID = @0 AND TagID = @1", p, t);
            return check;
        }
        public static void DeleteTagNotIn(int p, List<int> tags)
        {
            var db = new WebBanBanhConnectionDB();
            string tagsString = string.Join(",", tags);
            db.Execute("DELETE FROM Product_Tag WHERE ProductID = @0 AND TagID NOT IN (" + tagsString + ")", p);
        }

        public static void DeleteTag(int p)
        {
            var db = new WebBanBanhConnectionDB();
            db.Execute("DELETE FROM Product_Tag WHERE ProductID = @0", p);
        }
    }
}