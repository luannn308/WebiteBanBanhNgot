using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebsiteCakeNew.App_Start;

namespace WebsiteCakeNew.Areas.Admin.Controllers
{
    public class SaleController : Controller
    {
        [RoleUser]
        public ActionResult Index()
        {
            return View();
        }

        // GET: Admin/Sale/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: Admin/Sale/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Admin/Sale/Create
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

        // GET: Admin/Sale/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: Admin/Sale/Edit/5
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

        // GET: Admin/Sale/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: Admin/Sale/Delete/5
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
