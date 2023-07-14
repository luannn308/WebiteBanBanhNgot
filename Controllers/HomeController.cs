using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebsiteCakeNew.Models.BUS;

namespace WebsiteCakeNew.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            var db = ShopBUS.DanhSach();
            return View(db);
        }
        public ActionResult Shop()
        {
            return View();
        }
        public ActionResult About()
        {
            return View();
        }
        public ActionResult Blog()
        {
            return View();
        }
        public ActionResult Contact()
        {
            return View();
        }
    }
}