using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebBanBanhConnection;

namespace WebsiteCakeNew.Models.BUS
{
    public class CategoryBUS
    {
        public static IEnumerable<CATEGORY> DanhSach()
        {
            var db = new WebBanBanhConnectionDB();
            return db.Query<CATEGORY>("SELECT * FROM CATEGORY");
        }
    }
}