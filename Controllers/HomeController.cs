using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebsiteCakeNew.Models.BUS;

namespace WebsiteCakeNew.Controllers
{
    [Authorize]
    public class HomeController : Controller
    {
        [AllowAnonymous]
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