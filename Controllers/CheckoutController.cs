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
using System.Configuration;
using WebsiteCakeNew.Models;

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
        public ActionResult VnPayReturn()
        {
            if (Request.QueryString.Count > 0)
            {
                string vnp_HashSecret = ConfigurationManager.AppSettings["vnp_HashSecret"]; //Chuoi bi mat
                var vnpayData = Request.QueryString;
                VnPayLibrary vnpay = new VnPayLibrary();
                foreach (string s in vnpayData)
                {
                    //get all querystring data
                    if (!string.IsNullOrEmpty(s) && s.StartsWith("vnp_"))
                    {
                        vnpay.AddResponseData(s, vnpayData[s]);
                    }
                }
                int orderId = Convert.ToInt32(vnpay.GetResponseData("vnp_TxnRef"));
                long vnpayTranId = Convert.ToInt64(vnpay.GetResponseData("vnp_TransactionNo"));
                string vnp_ResponseCode = vnpay.GetResponseData("vnp_ResponseCode");
                string vnp_TransactionStatus = vnpay.GetResponseData("vnp_TransactionStatus");
                String vnp_SecureHash = Request.QueryString["vnp_SecureHash"];
                String TerminalID = Request.QueryString["vnp_TmnCode"];
                long vnp_Amount = Convert.ToInt64(vnpay.GetResponseData("vnp_Amount")) / 100;
                String bankCode = Request.QueryString["vnp_BankCode"];

                bool checkSignature = vnpay.ValidateSignature(vnp_SecureHash, vnp_HashSecret);
                if (checkSignature)
                {
                    if (vnp_ResponseCode == "00" && vnp_TransactionStatus == "00")
                    {
                        OrderBUS.UpdatePaymentStatus(orderId, "Đã thanh toán");
                        var order = OrderBUS.GetByID(orderId);
                        StringBuilder orderDetailsBuilder = new StringBuilder();
                        orderDetailsBuilder.AppendLine($"Sản phẩm: <br>");
                        int count = 0;
                        foreach (var item in OrderDetailBUS.GetByOrderID(orderId))
                        {
                            count++;
                            orderDetailsBuilder.AppendLine($"{count}. {ShopBUS.ChiTiet(item.ProductID).ProductName}: {string.Format("{0:N0}", item.ProductPrice)} VNĐ x {item.Quantity} <br>");
                        }
                        orderDetailsBuilder.AppendLine($"Ngày đặt hàng: {order.OrderDate} <br>");
                        orderDetailsBuilder.AppendLine($"Trạng thái đơn hàng: {order.OrderStatus} <br>");
                        orderDetailsBuilder.AppendLine($"Phương thức giao hàng: {order.ShippingMethod} <br>");
                        orderDetailsBuilder.AppendLine($"Tình trạng thanh toán: Đã thanh toán <br>");
                        orderDetailsBuilder.AppendLine($"Ngày giao hàng dự kiến: {order.ShippingDate} <br>");
                        orderDetailsBuilder.AppendLine($"Tổng cộng: {string.Format("{0:N0}", order.OrderTotal)} VNĐ <br>");
                        orderDetailsBuilder.AppendLine($"Địa chỉ giao hàng: {order.DeliveryAddress} <br>");
                        orderDetailsBuilder.AppendLine($"Phương thức thanh toán: {order.Payment} <br>");
                        var order_details = orderDetailsBuilder.ToString();
                        SendOrderConfirmationEmail(UserBUS.GetById(order.UserID).Email, order_details);
                        ViewBag.InnerText = "Giao dịch được thực hiện thành công. Cảm ơn quý khách đã sử dụng dịch vụ";
                        ViewBag.Money = "Bạn đã thanh toán thành công với số tiền thanh toán: " + string.Format("{0:N0}", order.OrderTotal) + " VNĐ";
                    }
                    else
                    {
                        //Thanh toan khong thanh cong. Ma loi: vnp_ResponseCode
                        ViewBag.InnerText = "Có lỗi xảy ra trong quá trình xử lý.Mã lỗi: " + vnp_ResponseCode;
                    }
                    //displayTmnCode.InnerText = "Mã Website (Terminal ID):" + TerminalID;
                    //displayTxnRef.InnerText = "Mã giao dịch thanh toán:" + orderId.ToString();
                    //displayVnpayTranNo.InnerText = "Mã giao dịch tại VNPAY:" + vnpayTranId.ToString();
                    //displayAmount.InnerText = "Số tiền thanh toán (VND):" + vnp_Amount.ToString();
                    //displayBankCode.InnerText = "Ngân hàng thanh toán:" + bankCode;
                }
            }
                return View();
        }
        public void SendOrderConfirmationEmail(string userEmail, string orderDetails )
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
                smtpClient.Send(mailMessage);
            }
            catch (Exception ex)
            {
                // Xử lý lỗi nếu có
                Console.WriteLine("Lỗi gửi email: " + ex.Message);
            }
        }
        // Hàm xử lý khi người dùng bấm nút "Đặt hàng"
        [HttpPost]
        public ActionResult PlaceOrder(ORDER order, string listCartID, int TypePaymentVN)
        {
            if(order.ShippingDate < DateTime.Now)
            {
                ViewBag.Error = "Chọn thời gian giao không hợp lệ";
                var db = ShoppingCartBUS.ViewShoppingCartWithUser((int)order.UserID);
                return View("Index",db);
            }
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
            var url = UrlPayment(TypePaymentVN, orderId);
            if (order.Payment == "Thanh toán qua VNPAY")
            {
                return Redirect(url);
            }
            var order_details = orderDetailsBuilder.ToString();
            SendOrderConfirmationEmail(UserBUS.GetById(order.UserID).Email, order_details);
            return RedirectToAction("Success");
        }
        public ActionResult Success()
        {
            return View();
        }
        public string UrlPayment(int PaymentTypeVN, int orderID)
        {
            var urlPayment = "";
            var order = OrderBUS.GetByID(orderID);
            string vnp_Returnurl = ConfigurationManager.AppSettings["vnp_Returnurl"]; //URL nhan ket qua tra ve 
            string vnp_Url = ConfigurationManager.AppSettings["vnp_Url"]; //URL thanh toan cua VNPAY 
            string vnp_TmnCode = ConfigurationManager.AppSettings["vnp_TmnCode"]; //Ma định danh merchant kết nối (Terminal Id)
            string vnp_HashSecret = ConfigurationManager.AppSettings["vnp_HashSecret"]; //Secret Key

            VnPayLibrary vnpay = new VnPayLibrary();

            vnpay.AddRequestData("vnp_Version", VnPayLibrary.VERSION);
            vnpay.AddRequestData("vnp_Command", "pay");
            vnpay.AddRequestData("vnp_TmnCode", vnp_TmnCode);
            vnpay.AddRequestData("vnp_Amount", (order.OrderTotal * 100).ToString());
            if (PaymentTypeVN == 1)
            {
                vnpay.AddRequestData("vnp_BankCode", "VNPAYQR");
            }
            else if (PaymentTypeVN == 2)
            {
                vnpay.AddRequestData("vnp_BankCode", "VNBANK");
            }
            else if (PaymentTypeVN == 3)
            {
                vnpay.AddRequestData("vnp_BankCode", "INTCARD");
            }
            DateTime date = (DateTime)order.OrderDate;
            string dateInsert = date.ToString("yyyyMMddHHmmss");
            vnpay.AddRequestData("vnp_CreateDate", dateInsert);
            vnpay.AddRequestData("vnp_CurrCode", "VND");
            vnpay.AddRequestData("vnp_IpAddr", Utils.GetIpAddress());
            vnpay.AddRequestData("vnp_Locale", "vn");
            vnpay.AddRequestData("vnp_OrderInfo", "Thanh toan don hang:" + order.OrderID);
            vnpay.AddRequestData("vnp_OrderType", "other"); //default value: other

            vnpay.AddRequestData("vnp_ReturnUrl", vnp_Returnurl);
            vnpay.AddRequestData("vnp_TxnRef", order.OrderID.ToString()); // Mã tham chiếu của giao dịch tại hệ thống của merchant. Mã này là duy nhất dùng để phân biệt các đơn hàng gửi sang VNPAY. Không được trùng lặp trong ngày


            urlPayment = vnpay.CreateRequestUrl(vnp_Url, vnp_HashSecret);
            return urlPayment;
        }
    }
}
