using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebBanBanhConnection;

namespace WebsiteCakeNew.Models.BUS
{
    public class TagBUS
    {
        public static IEnumerable<TAG> DanhSach()
        {
            var db = new WebBanBanhConnectionDB();
            return db.Query<TAG>("SELECT * FROM TAG");
        }
        public int SoLuongSanPham(int id)
        {
            var db = new WebBanBanhConnectionDB();
            return db.SingleOrDefault<int>("SELECT COUNT(*) FROM PRODUCT P JOIN PRODUCT_TAG PT ON P.ProductID = PT.ProductID JOIN TAG T ON PT.TagID = T.TagID WHERE T.TagID =  @0", id);
        }
        public static void AddTag(TAG tag)
        {
            var db = new WebBanBanhConnectionDB();
            db.Insert(tag);
        }
    }
}