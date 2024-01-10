using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.Mvc;
using WebsiteCakeNew.App_Start;
using WebsiteCakeNew.Models.BUS;
using System.Text;
using WebBanBanhConnection;

namespace WebsiteCakeNew.Areas.Admin.Controllers
{
    [RoleUser]
    public class OrderManagerController : Controller
    {
        public ActionResult Index(string sortBy)
        {
            ViewBag.sortBy = sortBy;
            var orders = OrderBUS.GetListOrder();
            if (sortBy == "default")
            {
                orders = OrderBUS.GetListOrder();
            }
            else if (sortBy == null)
            {
                orders = OrderBUS.GetListOrder();
            }
            else
            {
                orders = OrderBUS.GetListOrderByStatus(sortBy);
            }
            return View(orders);
        }

        // GET: Admin/Order/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: Admin/Order/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Admin/Order/Create
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

        // GET: Admin/Order/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: Admin/Order/Edit/5
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

        // GET: Admin/Order/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: Admin/Order/Delete/5
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
        public ActionResult UpdateStatus(int orderID, string status)
        {
            try
            {
                var order = OrderBUS.GetByID(orderID);
                order.OrderStatus = status;
                OrderBUS.UpdateOrderStatus(orderID, status);
                if(status == "Đang giao")
                {
                    OrderBUS.UpdateShippingDate(orderID);
                }
                if(status == "Giao hàng thành công")
                {
                    OrderBUS.UpdatePaymentStatus(orderID, "Đã thanh toán");
                }
                SendOrderConfirmationEmail(UserBUS.GetById(order.UserID).Email, OrderDetailBUS.GetByOrderID(orderID), order);
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
        [AllowAnonymous]
        public ActionResult CancelOrder(int orderID)
        {
            OrderBUS.UpdateOrderStatus(orderID, "Đã huỷ");
            return RedirectToAction("Index");
        }
        public void SendOrderConfirmationEmail(string userEmail, IEnumerable<ORDER_DETAIL> orderDetails, ORDER order)
        {
            string smtpServer = "smtp.gmail.com";
            int smtpPort = 587;
            string smtpUsername = "htktrang158@gmail.com";
            string smtpPassword = "lspt xnza jhlq fphj";
            string senderEmail = "htktrang158@gmail.com";

            // Tạo đối tượng SmtpClient để gửi email
            SmtpClient smtpClient = new SmtpClient(smtpServer);
            smtpClient.Port = smtpPort;
            smtpClient.Credentials = new NetworkCredential(smtpUsername, smtpPassword);
            smtpClient.EnableSsl = true;

            StringBuilder orderDetailsBuilder = new StringBuilder();
            orderDetailsBuilder.AppendLine($"Sản phẩm: <br>");
            int count = 0;
            foreach (var item in orderDetails)
            {
                count++;
                orderDetailsBuilder.AppendLine($"{count}. {ShopBUS.ChiTiet(item.ProductID).ProductName}: {string.Format("{0:N0}", item.ProductPrice)} VNĐ x {item.Quantity} <br>");
            }
            orderDetailsBuilder.AppendLine($"Ngày đặt hàng: {order.OrderDate} <br>");
            orderDetailsBuilder.AppendLine($"Trạng thái đơn hàng: {order.OrderStatus} <br>");
            orderDetailsBuilder.AppendLine($"Phương thức giao hàng: {order.ShippingMethod} <br>");
            orderDetailsBuilder.AppendLine($"Tình trạng thanh toán: {order.PaymentStatus} <br>");
            orderDetailsBuilder.AppendLine($"Ngày giao hàng dự kiến: {order.ShippingDate} <br>");
            orderDetailsBuilder.AppendLine($"Tổng cộng: {string.Format("{0:N0}", order.OrderTotal)} VNĐ <br>");
            orderDetailsBuilder.AppendLine($"Địa chỉ giao hàng: {order.DeliveryAddress} <br>");
            orderDetailsBuilder.AppendLine($"Phương thức thanh toán: {order.Payment} <br>");
            // Tạo đối tượng MailMessage để thiết lập nội dung email
            MailMessage mailMessage = new MailMessage(senderEmail, userEmail);
            mailMessage.Subject = "Tình trạng đơn hàng: " + order.OrderStatus;
            string body = @"
                            <!DOCTYPE html>
                            <html lang='en'>
                            <head>
                                <meta charset='UTF-8'>
                                <meta name='viewport' content='width=device-width, initial-scale=1.0'>
                            </head>
                            <body>
                                <h2>Cửa hàng Yummy Cookie</h2>
                                <p>Xin chào,</p>
                                <p>Đơn hàng " + order.OrderStatus + @". Dưới đây là chi tiết đơn hàng của bạn:</p>
                                <p><strong>Thông tin đơn hàng:</strong></p>
                                <p>" + orderDetailsBuilder + @"</p>
                                <p>Cảm ơn bạn đã lựa chọn sản phẩm của chúng tôi. Chúng tôi rất mong được phục vụ bạn trong tương lai.</p>
                                <p>Trân trọng,<br>Cửa hàng Yummy Cookie</p>
                                </body>
                                </html>
                            ";
            mailMessage.IsBodyHtml = true;
            mailMessage.Body = body;
            try
            {
                smtpClient.Send(mailMessage);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Lỗi gửi email: " + ex.Message);
            }
        }
    }
}
