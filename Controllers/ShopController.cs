using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebsiteCakeNew.Models.BUS;

namespace WebsiteCakeNew.Controllers
{
    public class ShopController : Controller
    {
        // GET: Shop
        public ActionResult Index(int page = 1, int pagesize = 8)
        {
            var db = ShopBUS.DanhSach().ToPagedList(page,pagesize);
            return View(db);
        }
        public ActionResult Category(int id, int page = 1, int pagesize = 8)
        {
            var db = ShopBUS.DanhMuc(id).ToPagedList(page, pagesize);
            if (id == 0)
            {
                return RedirectToAction("Index", "Shop");
            }
            var cateId = id;
            return View(db);
        }
        // GET: Shop/Details/5
        public ActionResult Details(int id)
        {
            var db = ShopBUS.ChiTiet(id);
            return View(db);
        }
        [HttpPost]
        public ActionResult SortProducts(string sortBy, int page = 1, int pagesize = 8)
        {
            var sortedList = ShopBUS.DanhSach();
            if (sortBy == "default")
            {
                sortedList = ShopBUS.DanhSach();
            }else if (sortBy == "az")
            {
                sortedList = ShopBUS.AtoZ();
            }else if (sortBy == "za")
            {
                sortedList = ShopBUS.ZtoA();
            }

            var pagedList = sortedList.ToPagedList(page, pagesize);

            // Trả về danh sách sản phẩm mới dưới dạng một partial view hoặc đoạn HTML
            return PartialView("_ProductList", pagedList);
        }
        // GET: Shop/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Shop/Create
        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Shop/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: Shop/Edit/5
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

        // GET: Shop/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: Shop/Delete/5
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
