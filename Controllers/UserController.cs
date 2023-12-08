using Microsoft.Owin.BuilderProperties;
using System;
using System.Collections.Generic;
using System.Drawing.Printing;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanBanhConnection;
using WebsiteCakeNew.Models.BUS;

namespace WebsiteCakeNew.Controllers
{
    public class UserController : Controller
    {
        // GET: User
        public ActionResult Index()
        {
            string username = (string)Session["UserName"];
            var db = new UserBUS();
            USER user = db.GetItem(username);
            if(user == null)
            {
                return RedirectToAction("../Account/Login");
            }
            return View(user);
        }
        [HttpPost]
        public ActionResult CreateShipping(USER_SHIPPING us) {
            var dbShipping = new UserShippingBUS();
            dbShipping.AddShippingUser(us);
            return RedirectToAction("Index");
        }
        [HttpPost]
        public ActionResult EditShipping(USER_SHIPPING us)
        {
            var dbShipping = new UserShippingBUS();
            dbShipping.UpdateAddress(us);
            return RedirectToAction("Index");
        }
        [HttpPost]
        public ActionResult UpdateDefaultShipping(int addressId)
        {
            var dbShipping = new UserShippingBUS();
            var address = dbShipping.GetAddressById(addressId);

            address.DefaultShipping = true;

            dbShipping.UpdateAddress(address);

            return Json(new { success = true });
        }
        [HttpPost]
        public ActionResult DeleteShipping(int userShippingID)
        {
            var dbShipping = new UserShippingBUS();
            var address = dbShipping.GetAddressById(userShippingID);
            if(address.DefaultShipping == true)
            {
                var addressDefault = dbShipping.GetFirstShipping(address.UserID);
                if(addressDefault != null)
                {
                    addressDefault.DefaultShipping = true;
                    dbShipping.UpdateAddress(addressDefault);
                }                            
            }
            dbShipping.DeleteAddress(address);
            return Json(new { success = true });
        }
        // USER PAYMENT
        [HttpPost]
        public ActionResult CreatePayment(USER_PAYMENT up)
        {
            var dbPayment = new UserPaymentBUS();
            dbPayment.AddPayment(up);
            return RedirectToAction("Index");
        }
        [HttpPost]
        public ActionResult UpdateDefaultPayment(int paymentId)
        {
            var dbPayment = new UserPaymentBUS();
            var pay = dbPayment.GetPaymentById(paymentId);

            pay.DefaultPayment = true;

            dbPayment.UpdatePayment(pay);

            return Json(new { success = true });
        }
    }
}