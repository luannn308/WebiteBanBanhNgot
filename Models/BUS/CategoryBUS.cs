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
        public static CATEGORY ChiTiet(int id)
        {
            var db = new WebBanBanhConnectionDB();
            return db.SingleOrDefault<CATEGORY>("Select * from CATEGORY WHERE CategoryID = @0", id);
        }
        public string DanhMucCha(int id)
        {
            var db = new WebBanBanhConnectionDB();
            return db.SingleOrDefault<string>("Select CategoryName from CATEGORY WHERE CategoryID = @0", id);
        }
        public int SoLuongSanPham(int id)
        {
            var db = new WebBanBanhConnectionDB();
            return db.SingleOrDefault<int>("SELECT COUNT(*) FROM PRODUCT P JOIN PRODUCT_CATEGORY PC ON P.ProductID = PC.ProductID JOIN CATEGORY C ON PC.CategoryID = C.CategoryID WHERE C.CategoryID =  @0", id);
        }
        public static void AddCategory(CATEGORY cate)
        {
            var db = new WebBanBanhConnectionDB();
            db.Insert(cate);
        }
        public static void UpdateCategory(int id, CATEGORY cate)
        {
            var db = new WebBanBanhConnectionDB();
            db.Update(cate, id);
        }
        public static void DeleteCategory(int id)
        {
            var db = new WebBanBanhConnectionDB();
            db.Execute("DELETE FROM PRODUCT_CATEGORY WHERE CategoryID = @0", id);
            db.Execute("UPDATE CATEGORY SET ParentID = @0 WHERE ParentID = @1", null, id);
            var category = db.SingleOrDefault<CATEGORY>("SELECT * FROM CATEGORY WHERE CategoryID = @0", id);
            if (category != null)
            {
                db.Delete(category);
            }
        }
        public static int GetIdByName(string name)
        {
            var db=new WebBanBanhConnectionDB();
            return db.SingleOrDefault<int>("Select CategoryID From CATEGORY WHERE CategoryName = @0", name);
        }
    }
}