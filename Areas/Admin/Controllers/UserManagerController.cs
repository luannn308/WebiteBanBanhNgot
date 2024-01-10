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
    public class UserManagerController : Controller
    {
        // GET: Admin/UserManager
        public ActionResult Index()
        {
            var dbUser = new UserBUS();
            var list = dbUser.GetList();
            ViewBag.SuccessMessage = TempData["SuccessMessage"] as string;
            return View(list);
        }

        // GET: Admin/UserManager/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: Admin/UserManager/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Admin/UserManager/Create
        [HttpPost]
        public ActionResult Create(USER user, int roleID)
        {
            try
            {
                var dbUser = new UserBUS();
                var result = dbUser.AddUser(user);
                switch (result)
                {
                    case 1:
                        int createdUserID = dbUser.GetIdByUserName(user.UserName);
                        USER_ROLE userRole = new USER_ROLE
                        {
                           UserID = createdUserID,
                           RoleID = roleID
                        };
                        User_RoleBUS.AddUserRole(userRole);
                        dbUser.CreateShoppingCart(user.UserName);
                        TempData["SuccessMessage"] = "Thêm người dùng thành công";
                        return RedirectToAction("Index");
                    case 0:
                        ModelState.AddModelError("", "Username đã tồn tại");
                        return View();
                    case -1:
                        ModelState.AddModelError("", "Email đã tồn tại");
                        return View();
                    case -2:
                        ModelState.AddModelError("", "Mật khâu phải có ít nhất một chữ thường, một chữ hoa và một số");
                        return View();
                    case -3:
                        ModelState.AddModelError("", "Email không phải là địa chỉ email hợp lệ.");
                        return View();
                    default:
                        ModelState.AddModelError("", "Đăng ký không thành công");
                        return View();
                }
            }
            catch
            {
                return View();
            }
        }

        // GET: Admin/UserManager/Edit/5
        public ActionResult Edit(int id)
        {
            var db = UserBUS.GetById(id);
            return View(db);
        }

        // POST: Admin/UserManager/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, USER u, int roleID)
        {
            try
            {
                var dbUser = new UserBUS();
                var result = dbUser.UpdateUser(id, u, roleID);
                switch (result)
                {
                    case 1:
                        TempData["SuccessMessage"] = "Lưu thay đổi người dùng thành công";
                        return RedirectToAction("Index");
                    case 0:
                        ModelState.AddModelError("", "Username đã tồn tại");
                        return View(u);
                    case -1:
                        ModelState.AddModelError("", "Email đã tồn tại");
                        return View(u);
                    case -2:
                        ModelState.AddModelError("", "Email không phải là địa chỉ email hợp lệ.");
                        return View(u);
                    default:
                        ModelState.AddModelError("", "Chỉnh sửa không thành công");
                        return View(u);
                }
            }
            catch
            {
                return View();
            }
        }

        // GET: Admin/UserManager/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: Admin/UserManager/Delete/5
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
        [AllowAnonymous]
        public ActionResult RemoveUser(int userID)
        {
            var db = new UserBUS();
            db.DeleteUser(userID);
            return RedirectToAction("Index");
        }
    }
}
