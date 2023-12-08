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
        public static IEnumerable<PRODUCT> DanhSachCon()
        {
            var db = new WebBanBanhConnectionDB();
            return db.Query<PRODUCT>("SELECT * FROM PRODUCT WHERE StockNumber > 0");
        }
        public static IEnumerable<PRODUCT> AtoZ()
        {
            var db = new WebBanBanhConnectionDB();
            return db.Query<PRODUCT>("SELECT * FROM PRODUCT WHERE StockNumber > 0 ORDER BY ProductName ASC ");
        }
        public static IEnumerable<PRODUCT> ZtoA()
        {
            var db = new WebBanBanhConnectionDB();
            return db.Query<PRODUCT>("SELECT * FROM PRODUCT WHERE StockNumber > 0 ORDER BY ProductName DESC");
        }
        public static IEnumerable<PRODUCT> PriceDESC()
        {
            var db = new WebBanBanhConnectionDB();
            return db.Query<PRODUCT>("SELECT * FROM PRODUCT WHERE StockNumber > 0 ORDER BY Price DESC");
        }
        public static IEnumerable<PRODUCT> PriceASC()
        {
            var db = new WebBanBanhConnectionDB();
            return db.Query<PRODUCT>("SELECT * FROM PRODUCT WHERE StockNumber > 0 ORDER BY Price ASC");
        }
        public static PRODUCT ChiTiet(int id)
        {
            var db = new WebBanBanhConnectionDB();
            return db.SingleOrDefault<PRODUCT>("Select * from PRODUCT WHERE ProductID = @0",id);
        }
        public static IEnumerable<PRODUCT> DanhMuc(int id, string sortBy)
        {
            var db = new WebBanBanhConnectionDB();

            var query = "SELECT p.* FROM PRODUCT p " +
                        "INNER JOIN PRODUCT_CATEGORY pc ON p.ProductID = pc.ProductID " +
                        "INNER JOIN CATEGORY c ON pc.CategoryID = c.CategoryID " +
                        "WHERE c.CategoryID = @0 AND p.StockNumber > 0";

            if (!string.IsNullOrEmpty(sortBy))
            {
                switch (sortBy)
                {
                    case "az":
                        query += " ORDER BY p.ProductName ASC";
                        break;
                    case "za":
                        query += " ORDER BY p.ProductName DESC";
                        break;
                    case "asc":
                        query += " ORDER BY p.Price ASC";
                        break;
                    case "desc":
                        query += " ORDER BY p.Price DESC";
                        break;
                    case "old":
                        query += " ORDER BY p.PublicationDate ASC";
                        break;
                    default:
                        break;
                }
            }

            return db.Query<PRODUCT>(query, id);
        }

        public static IEnumerable<PRODUCT> OldProduct()
        {
            var db = new WebBanBanhConnectionDB();
            return db.Query<PRODUCT>("SELECT * FROM PRODUCT WHERE StockNumber > 0 ORDER BY PublicationDate ASC");
        }
        public static IEnumerable<PRODUCT> TopNew()
        {
            var db = new WebBanBanhConnectionDB();
            return db.Query<PRODUCT>("SELECT * FROM PRODUCT WHERE StockNumber > 0 ORDER BY PublicationDate DESC");
        }
        public static IEnumerable<PRODUCT> TopHot()
        {
            var db = new WebBanBanhConnectionDB();
            return db.Query<PRODUCT>("SELECT * FROM PRODUCT WHERE StockNumber > 0 ORDER BY ProductName DESC");
        }
        public static IEnumerable<PRODUCT> RelatedProduct(int id)
        {
            var db = new WebBanBanhConnectionDB();
            int pCategory = db.SingleOrDefault<int>("SELECT CategoryID FROM [PRODUCT_CATEGORY] WHERE ProductID = @0", id);
            return db.Query<PRODUCT>("SELECT * FROM PRODUCT p, PRODUCT_CATEGORY pc WHERE p.ProductID = pc.ProductID AND pc.CategoryID = @0 AND p.ProductID <> @1 AND p.StockNumber > 0", pCategory, id);
        }
        public string GetCategoryProduct(int id)
        {
            var db = new WebBanBanhConnectionDB();
            var pCategory = db.Query<PRODUCT_CATEGORY>("SELECT * FROM [PRODUCT_CATEGORY] WHERE ProductID = @0", id).FirstOrDefault();
            if (pCategory != null)
            {
                var cate = db.SingleOrDefault<CATEGORY>("SELECT * FROM [CATEGORY] WHERE CategoryID = @0", pCategory.CategoryID);
                if (cate != null)
                {
                    return cate.CategoryName;
                }
            }
            return string.Empty;
        }
        public string GetAllCategoriesForProduct(int id)
        {
            var query = @"SELECT c.CategoryName FROM PRODUCT_CATEGORY pc JOIN CATEGORY c ON pc.CategoryID = c.CategoryID WHERE pc.ProductID = @0";

            var db = new WebBanBanhConnectionDB();
            var categories = db.Fetch<string>(query, id);
            return string.Join(", ", categories);
        }
        public string GetAllTagsForProduct(int id)
        {
            var query = @"SELECT t.TagName FROM PRODUCT_TAG pt JOIN TAG t ON pt.TagID = t.TagID WHERE pt.ProductID = @0";

            var db = new WebBanBanhConnectionDB();
            var tags = db.Fetch<string>(query, id);

            return string.Join(", ", tags);
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
            db.Execute("DELETE FROM PRODUCT_CATEGORY WHERE ProductID = @0", id);
            var product = db.SingleOrDefault<PRODUCT>("SELECT * FROM PRODUCT WHERE ProductID = @0", id);
            if (product != null)
            {
                db.Delete(product);
            }
        }
        public static void UpdateQuantityAfterOrder(int productID, int count)
        {
            PRODUCT productUpdate = ChiTiet(productID);
            productUpdate.StockNumber = productUpdate.StockNumber - count;
            UpdateProduct(productID, productUpdate);
        }
    }
}