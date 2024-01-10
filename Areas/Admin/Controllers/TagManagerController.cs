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
    public class TagManagerController : Controller
    {
        public ActionResult Index()
        {
            var ds = TagBUS.DanhSach();
            return View(ds);
        }

        // GET: Admin/Tag/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: Admin/Tag/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Admin/Tag/Create
        [HttpPost]
        public ActionResult Create(TAG tag)
        {
            try
            {
                // TODO: Add insert logic here
                TagBUS.AddTag(tag);
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Admin/Tag/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: Admin/Tag/Edit/5
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

        // GET: Admin/Tag/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: Admin/Tag/Delete/5
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
