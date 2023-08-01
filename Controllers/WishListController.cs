using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebsiteCakeNew.Controllers
{
    public class WishListController : Controller
    {
        // GET: WishList
        public ActionResult Index()
        {
            return View();
        }

        // GET: WishList/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: WishList/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: WishList/Create
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

        // GET: WishList/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: WishList/Edit/5
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

        // GET: WishList/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: WishList/Delete/5
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
