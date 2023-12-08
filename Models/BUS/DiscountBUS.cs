using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebBanBanhConnection;

namespace WebsiteCakeNew.Models.BUS
{
    public class DiscountBUS
    {
        private WebBanBanhConnectionDB db;
        public DiscountBUS()
        {
            db = new WebBanBanhConnectionDB();
        }
        public static int GetPercentByID(int? id)
        {
            var dbDiscount = new WebBanBanhConnectionDB();
            return dbDiscount.SingleOrDefault<int>("SELECT DiscountPercentage FROM DISCOUNT WHERE DiscountID = @0", id);
        }
        public IEnumerable<DISCOUNT> GetListDiscount()
        {
            return db.Query<DISCOUNT>("SELECT * FROM DISCOUNT");
        }
        public static string GetCodeDiscount(int? id)
        {
            var dbDiscount = new WebBanBanhConnectionDB();
            return dbDiscount.SingleOrDefault<string>("SELECT DiscountCode FROM DISCOUNT WHERE DiscountID = @0", id);
        }
    }
}