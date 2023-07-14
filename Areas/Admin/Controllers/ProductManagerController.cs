using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
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
