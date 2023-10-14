using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanBanhConnection;
using WebsiteCakeNew.Models.BUS;

namespace WebsiteCakeNew.Areas.Admin.Controllers
{
    public class ProductManagerController : Controller
    {
        // GET: Admin/ProductManager
        public ActionResult Index()
        {
            var ds = ShopBUS.DanhSach();
            return View(ds);
        }

        // GET: Admin/ProductManager/Details/5
        public ActionResult Details(int id)
        {
            return View(ShopBUS.ChiTiet(id));
        }

        // GET: Admin/ProductManager/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Admin/ProductManager/Create
        [HttpPost]
        public ActionResult Create(PRODUCT p, string SelectedCategoryIDs, string SelectedTagIDs)
        {
            try
            {
                string[] selectedCategoryIDArray = SelectedCategoryIDs.Split(',');
                string[] selectedTagIDArray = SelectedTagIDs.Split(',');
                // TODO: Lưu thông tin sản phẩm vào bảng Product
                ShopBUS.AddProduct(p);

                // TODO: Lấy ID của sản phẩm đã tạo
                int createdProductID = p.ProductID;
                if(selectedCategoryIDArray[0] != "")
                {
                    foreach (var categoryID in selectedCategoryIDArray)
                    {
                        int categoryId = Convert.ToInt32(categoryID);
                        PRODUCT_CATEGORY productCategory = new PRODUCT_CATEGORY
                        {
                            ProductID = createdProductID,
                            CategoryID = categoryId
                        };

                        // TODO: Lưu bản ghi vào bảng Product_category
                        Product_CategoryBUS.AddProductCategory(productCategory);
                    }
                }
                // TODO: Thêm các bản ghi vào bảng Product_category
                if(selectedTagIDArray[0] != "")
                {
                    foreach (var tagID in selectedTagIDArray)
                    {
                        int tagId = Convert.ToInt32(tagID);
                        PRODUCT_TAG productTag = new PRODUCT_TAG
                        {
                            ProductID = createdProductID,
                            TagID = tagId
                        };

                        // TODO: Lưu bản ghi vào bảng Product_category
                        Product_TagBUS.AddProductTag(productTag);
                    }
                } 
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
        [HttpPost]
        public ActionResult UploadImage(HttpPostedFileBase file)
        {
            if (file != null && file.ContentLength > 0)
            {
                // Xử lý và lưu trữ tệp tin ở đây
                string fileName = Path.GetFileName(file.FileName);
                string filePath = Path.Combine(Server.MapPath("~/Content/img/shop/"), fileName);
                file.SaveAs(filePath);

                // Trả về đường dẫn tệp tin đã lưu (nếu cần)
                return Json(new { filePath });
            }

            // Trường hợp không có tệp tin hoặc tệp tin không có nội dung
            return Json(new { filePath = "" });
        }
        // GET: Admin/ProductManager/Edit/5
        public ActionResult Edit(int id)
        {
            var db = ShopBUS.ChiTiet(id);
            return View(db);
        }

        // POST: Admin/ProductManager/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, PRODUCT p, string SelectedCategoryIDs, string SelectedTagIDs)
        {
            try
            {
                // TODO: Add update logic here
                if(SelectedCategoryIDs != "")
                {
                    var selectedCategoryIDArray = SelectedCategoryIDs.Split(',').Select(int.Parse).ToList();
                    Product_CategoryBUS.DeleteCate(id);
                    foreach (var categoryID in selectedCategoryIDArray)
                    {
                        int categoryId = Convert.ToInt32(categoryID);
                        PRODUCT_CATEGORY productCategory = new PRODUCT_CATEGORY
                        {
                            ProductID = id,
                            CategoryID = categoryId
                        };

                        // TODO: Lưu bản ghi vào bảng Product_category
                        Product_CategoryBUS.AddProductCategory(productCategory);
                    }
                }
                if(SelectedTagIDs != "")
                {
                var selectedTagIDArray = SelectedTagIDs.Split(',').Select(int.Parse).ToList();
                Product_TagBUS.DeleteTag(id);
                foreach (var tagID in selectedTagIDArray)
                {
                    int tagId = Convert.ToInt32(tagID);
                    PRODUCT_TAG productTag = new PRODUCT_TAG
                    {
                        ProductID = id,
                        TagID = tagId
                    };

                    // TODO: Lưu bản ghi vào bảng Product_category
                    Product_TagBUS.AddProductTag(productTag);
                }
                }
                ShopBUS.UpdateProduct(id, p);
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Admin/ProductManager/Delete/5
        public ActionResult Delete(int id)
        {
            var db = ShopBUS.ChiTiet(id);
            return View(db);
        }

        // POST: Admin/ProductManager/Delete/5
        [HttpPost]
        public ActionResult Delete(int id,PRODUCT p)
        {
            try
            {
                // TODO: Add delete logic here
                Product_CategoryBUS.DeleteCate(id);
                Product_TagBUS.DeleteTag(id);
                CartItemBUS.DeleteByProductID(id);
                ShopBUS.DeleteProduct(id);
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
