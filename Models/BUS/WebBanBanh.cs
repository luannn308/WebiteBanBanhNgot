using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebBanBanhConnection;

namespace WebsiteCakeNew.Models.BUS
{
    public class WebBanBanh
    {
        public static IEnumerable<PRODUCT> DanhSach() {
            var db = new WebBanBanhConnectionDB();
            return db.Query<PRODUCT>("Select * from PRODUCT");
        }
        public static PRODUCT ChiTiet(int id)
        {
            var db = new WebBanBanhConnectionDB();
            return db.SingleOrDefault<PRODUCT>("Select * from PRODUCT WHERE ProductID = @0",id);
        }
    }
}