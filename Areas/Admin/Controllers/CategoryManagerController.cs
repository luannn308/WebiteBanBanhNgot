using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanBanhConnection;
using WebsiteCakeNew.App_Start;
using WebsiteCakeNew.Models.BUS;

namespace WebsiteCakeNew.Areas.Admin.Controllers
{
    [RoleUser]
    public class CategoryManagerController : Controller
    {
        // GET: Admin/CategoryManager
        public ActionResult Index()
        {
            var ds = CategoryBUS.DanhSach();
            ViewBag.SuccessMessage = TempData["SuccessMessage"] as string;
            return View(ds);
        }

        // GET: Admin/CategoryManager/Details/5
        public ActionResult Details(int id)
        {
            return View(CategoryBUS.ChiTiet(id));
        }

        // GET: Admin/CategoryManager/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Admin/CategoryManager/Create
        [HttpPost]
        public ActionResult Create(CATEGORY cate)
        {
            try
            {
                // TODO: Add insert logic here
                CategoryBUS.AddCategory(cate);
                TempData["SuccessMessage"] = "Thêm danh mục thành công";
                return RedirectToAction("Index");
            }
            catch
            {
                ViewBag.Error = "Thêm danh mục thất bại";
                return View();
            }
        }

        // GET: Admin/CategoryManager/Edit/5
        public ActionResult Edit(int id)
        {
            var db = CategoryBUS.ChiTiet(id);
            return View(db);
        }

        // POST: Admin/CategoryManager/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, CATEGORY cate)
        {
            try
            {
                // TODO: Add update logic here
                CategoryBUS.UpdateCategory(id, cate);
                TempData["SuccessMessage"] = "Lưu thay đổi danh mục thành công";
                return RedirectToAction("Index");
            }
            catch
            {
                ViewBag.Error = "Lưu thay đổi danh mục thất bại";
                var db = CategoryBUS.ChiTiet(id);
                return View(db);
            }
        }

        // GET: Admin/CategoryManager/Delete/5
        public ActionResult Delete(int id)
        {
            var db = CategoryBUS.ChiTiet(id);
            return View(db);
        }

        // POST: Admin/CategoryManager/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here
                CategoryBUS.DeleteCategory(id);
                TempData["SuccessMessage"] = "Xoá danh mục thành công";
                return RedirectToAction("Index");
            }
            catch
            {
                ViewBag.Error = "Xoá danh mục thất bại";
                var db = CategoryBUS.ChiTiet(id);
                return View(db);
            }
        }
    }
}
