using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebBanBanhConnection;

namespace WebsiteCakeNew.Models.BUS
{
    public class ShopBUS
    {
        public static IEnumerable<PRODUCT> DanhSach() {
            var db = new WebBanBanhConnectionDB();
            return db.Query<PRODUCT>("SELECT * FROM PRODUCT");
        }
        public static PRODUCT ChiTiet(int id)
        {
            var db = new WebBanBanhConnectionDB();
            return db.SingleOrDefault<PRODUCT>("Select * from PRODUCT WHERE ProductID = @0",id);
        }
        public static IEnumerable<PRODUCT> DanhMuc(int id)
        {
            var db = new WebBanBanhConnectionDB();
            return db.Query<PRODUCT>("SELECT p.* FROM PRODUCT p INNER JOIN PRODUCT_CATEGORY pc ON p.ProductID = pc.ProductID INNER JOIN Category c ON pc.CategoryID = c.CategoryID WHERE c.CategoryID = @0", id);
        }
        public static IEnumerable<PRODUCT> TopNew()
        {
            var db = new WebBanBanhConnectionDB();
            return db.Query<PRODUCT>("SELECT * FROM PRODUCT ORDER BY PublicationDate DESC");
        }
        public static IEnumerable<PRODUCT> TopHot()
        {
            var db = new WebBanBanhConnectionDB();
            return db.Query<PRODUCT>("SELECT * FROM PRODUCT ORDER BY Rating DESC");
        }
        public static void AddProduct(PRODUCT p)
        {
            var db = new WebBanBanhConnectionDB();
            db.Insert(p);
        }
        public static void UpdateProduct(int id,PRODUCT p)
        {
            var db = new WebBanBanhConnectionDB();
            db.Update(p, id);
        }
        public static void DeleteProduct(int id)
        {
            var db = new WebBanBanhConnectionDB();
            var product = db.SingleOrDefault<PRODUCT>("SELECT * FROM PRODUCT WHERE ProductID = @0", id);
            if (product != null)
            {
                db.Delete(product);
            }
        }
    }
}