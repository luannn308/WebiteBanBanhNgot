using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.Mvc;
using WebBanBanhConnection;
using WebsiteCakeNew.Models.BUS;
using System.Text;

namespace WebsiteCakeNew.Controllers
{
    public class CheckoutController : Controller
    {
        // GET: Checkout
        public ActionResult Index(int shoppingCartId)
        {
            var db = ShoppingCartBUS.GetByID(shoppingCartId);
            return View(db);
        }
        public void SendOrderConfirmationEmail(string userEmail, string orderDetails )
        {
            string smtpServer = "smtp.gmail.com";
            int smtpPort = 587;
            string smtpUsername = "luannn308@gmail.com";
            string smtpPassword = "lktu efbb qaya uhlp";
            string senderEmail = "luannn308@gmail.com";

            // Tạo đối tượng SmtpClient để gửi email
            SmtpClient smtpClient = new SmtpClient(smtpServer);
            smtpClient.Port = smtpPort;
            smtpClient.Credentials = new NetworkCredential(smtpUsername, smtpPassword);
            smtpClient.EnableSsl = true;

            // Tạo đối tượng MailMessage để thiết lập nội dung email
            MailMessage mailMessage = new MailMessage(senderEmail, userEmail);
            mailMessage.Subject = "Xác nhận đơn hàng";
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
                                <p>Cảm ơn bạn đã đặt hàng tại Cửa hàng Yummy Cookie. Dưới đây là chi tiết đơn hàng của bạn:</p>
                                <p><strong>Thông tin đơn hàng:</strong></p>
                                <p>" + orderDetails + @"</p>
                                <p>Cảm ơn bạn đã lựa chọn sản phẩm của chúng tôi. Chúng tôi rất mong được phục vụ bạn trong tương lai.</p>
                                <p>Trân trọng,<br>Cửa hàng Yummy Cookie</p>
                                </body>
                                </html>
                            ";
            mailMessage.IsBodyHtml = true;
            mailMessage.Body = body;

            try
            {
                smtpClient.Send(mailMessage); // Gửi email
            }
            catch (Exception ex)
            {
                // Xử lý lỗi nếu có
                Console.WriteLine("Lỗi gửi email: " + ex.Message);
            }
        }
        // Hàm xử lý khi người dùng bấm nút "Đặt hàng"
        [HttpPost]
        public ActionResult PlaceOrder(ORDER order, string listCartID)
        {
            // Tạo đối tượng ORDER từ dữ liệu form và các biến khác
            ORDER newOrder = new ORDER
            {
                OrderDate = DateTime.Now,
                OrderStatus = "Đang chờ xử lý",
                ShippingMethod = order.ShippingMethod, 
                PaymentStatus = order.PaymentStatus, 
                ShippingDate = order.ShippingDate,
                OrderTotal = order.OrderTotal,
                DeliveryAddress = order.DeliveryAddress, 
                Payment = order.Payment, 
                UserID = order.UserID
            };

            // Lưu đối tượng ORDER vào cơ sở dữ liệu
            int orderId = OrderBUS.InsertOrder(newOrder);
            string[] cartItemIDArray = listCartID.Split(',');
            StringBuilder orderDetailsBuilder = new StringBuilder();
            orderDetailsBuilder.AppendLine($"Sản phẩm: <br>");
            int count = 0;
            foreach (var item in cartItemIDArray)
            {
                count++;
                CART_ITEM cart =  CartItemBUS.GetCartById(Convert.ToInt32(item));
                ORDER_DETAIL orderDetail = new ORDER_DETAIL
                {
                    OrderID = orderId,
                    ProductID = cart.ProductID,
                    Quantity = cart.Quantity,
                    ProductPrice = cart.Subtotal / cart.Quantity
                };
                orderDetailsBuilder.AppendLine($"{count}. {ShopBUS.ChiTiet(orderDetail.ProductID).ProductName}: {string.Format("{0:N0}", orderDetail.ProductPrice)} VNĐ x {orderDetail.Quantity} <br>");
                CartItemBUS.DeleteCartItem(Convert.ToInt32(item));
                OrderDetailBUS.InsertOrderDetail(orderDetail);
                ShopBUS.UpdateQuantityAfterOrder(cart.ProductID, cart.Quantity);
            }
            orderDetailsBuilder.AppendLine($"Ngày đặt hàng: {DateTime.Now} <br>");
            orderDetailsBuilder.AppendLine($"Trạng thái đơn hàng: Đang chờ xử lý <br>");
            orderDetailsBuilder.AppendLine($"Phương thức giao hàng: {order.ShippingMethod} <br>");
            orderDetailsBuilder.AppendLine($"Tình trạng thanh toán: {order.PaymentStatus} <br>");
            orderDetailsBuilder.AppendLine($"Ngày giao hàng dự kiến: {order.ShippingDate} <br>");
            orderDetailsBuilder.AppendLine($"Tổng cộng: {string.Format("{0:N0}", order.OrderTotal)} VNĐ <br>");
            orderDetailsBuilder.AppendLine($"Địa chỉ giao hàng: {order.DeliveryAddress} <br>");
            orderDetailsBuilder.AppendLine($"Phương thức thanh toán: {order.Payment} <br>");

            var order_details = orderDetailsBuilder.ToString();
            SendOrderConfirmationEmail(UserBUS.GetById(order.UserID).Email, order_details);
            return RedirectToAction("../Home/Index");
        }

    }
}
