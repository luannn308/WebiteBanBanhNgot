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
            return View();
        }

        // GET: Admin/ProductManager/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Admin/ProductManager/Create
        [HttpPost]
        public ActionResult Create(PRODUCT p)
        {
            try
            {
                // TODO: Add insert logic here
                ShopBUS.AddProduct(p);
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
            return View();
        }

        // POST: Admin/ProductManager/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

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
            return View();
        }

        // POST: Admin/ProductManager/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
