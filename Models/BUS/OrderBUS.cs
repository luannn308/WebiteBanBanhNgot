using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebBanBanhConnection;

namespace WebsiteCakeNew.Models.BUS
{
    public class OrderBUS
    {
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
    }
}