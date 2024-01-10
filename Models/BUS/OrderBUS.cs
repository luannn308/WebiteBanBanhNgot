using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebBanBanhConnection;

namespace WebsiteCakeNew.Models.BUS
{
    public class OrderBUS
    {
        public static IEnumerable<ORDER> GetListOrder() {
            var db = new WebBanBanhConnectionDB();
            return db.Query<ORDER>("SELECT * FROM [ORDER]"); 
        }
        public static IEnumerable<ORDER> GetListOrderByUser(int userId)
        {
            var db = new WebBanBanhConnectionDB();
            return db.Query<ORDER>("SELECT * FROM [ORDER] WHERE UserID = @0", userId);
        }
        public static IEnumerable<ORDER> GetListOrderByStatus(string status)
        {
            var db = new WebBanBanhConnectionDB();
            return db.Query<ORDER>("SELECT * FROM [ORDER] WHERE OrderStatus = @0", status);
        }
        public static int CountOrder()
        {
            var db = new WebBanBanhConnectionDB();
            return db.SingleOrDefault<int>("SELECT COUNT(OrderID) AS NonCancelledOrders FROM [ORDER] WHERE OrderStatus <> 'Đã huỷ';");
        }
        public static int InsertOrder(ORDER order)
        {
            var db = new WebBanBanhConnectionDB();
            string insertQuery = @"INSERT INTO [ORDER] (OrderDate, OrderStatus, ShippingMethod, PaymentStatus, ShippingDate, OrderTotal, DeliveryAddress, Payment, UserID) VALUES (@OrderDate, @OrderStatus, @ShippingMethod, @PaymentStatus, @ShippingDate, @OrderTotal, @DeliveryAddress, @Payment, @UserID)";
            db.Execute(insertQuery, new
            {
                order.OrderDate,
                order.OrderStatus,
                order.ShippingMethod,
                order.PaymentStatus,
                order.ShippingDate,
                order.OrderTotal,
                order.DeliveryAddress,
                order.Payment,
                order.UserID
            });
            return db.SingleOrDefault<int>("SELECT TOP 1 OrderID FROM [ORDER] WHERE UserID = @0 ORDER BY OrderDate DESC;", order.UserID);
        }
        public static void UpdateOrderStatus(int orderId, string newStatus)
        {
            using (var db = new WebBanBanhConnectionDB())
            {
                var order = db.SingleOrDefault<ORDER>("SELECT * FROM [ORDER] WHERE OrderID = @0", orderId);

                if (order != null)
                {
                    db.Execute("UPDATE [ORDER] SET OrderStatus = @0 WHERE OrderID = @1", newStatus, orderId);
                }
            }
        }
        public static void UpdateShippingDate(int orderId)
        {
            using (var db = new WebBanBanhConnectionDB())
            {
                var order = db.SingleOrDefault<ORDER>("SELECT * FROM [ORDER] WHERE OrderID = @0", orderId);

                if (order != null)
                {
                    db.Execute("UPDATE [ORDER] SET ShippingDate = @0 WHERE OrderID = @1", DateTime.Now , orderId);
                }
            }
        }
        public static void UpdatePaymentStatus(int orderId, string status)
        {
            using (var db = new WebBanBanhConnectionDB())
            {
                var order = db.SingleOrDefault<ORDER>("SELECT * FROM [ORDER] WHERE OrderID = @0", orderId);

                if (order != null)
                {
                    db.Execute("UPDATE [ORDER] SET PaymentStatus = @0 WHERE OrderID = @1", status, orderId);
                }
            }
        }
        public static ORDER GetByID(int id)
        {
            var db = new WebBanBanhConnectionDB();
            return db.SingleOrDefault<ORDER>("SELECT * FROM [ORDER] WHERE OrderID = @0", id);
        }
        public static float SumAllOrderTotal()
        {
            var db = new WebBanBanhConnectionDB();
            int count = db.SingleOrDefault<int>("SELECT COUNT(OrderID) AS NonCancelledOrders FROM [ORDER] WHERE OrderStatus  = 'Giao hàng thành công'");
            if(count > 0)
            {
                return db.SingleOrDefault<float>("SELECT SUM(OrderTotal) AS DoanhThu FROM [ORDER] WHERE OrderStatus = 'Giao hàng thành công'");
            }
            return 0;
        }
    }
}