using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebBanBanhConnection;

namespace WebsiteCakeNew.Models.BUS
{
    public class OrderDetailBUS
    {
        public static void InsertOrderDetail(ORDER_DETAIL orderDetail)
        {
            var db = new WebBanBanhConnectionDB();
            db.Insert(orderDetail);
        }
        public static IEnumerable<ORDER_DETAIL> GetByOrderID(int orderID)
        {
            var db = new WebBanBanhConnectionDB();
            return db.Query<ORDER_DETAIL>("SELECT * FROM ORDER_DETAIL WHERE OrderID = @0", orderID);
        }
        public static List<ProductStatistics> StatisticProduct(string year = null, int quy = 0)
        {
            var db = new WebBanBanhConnectionDB();
            var sql = PetaPoco.Sql.Builder
                .Select("OD.ProductID, P.ProductName, SUM(OD.ProductPrice * OD.Quantity) AS ProductRevenue, P.Price, SUM(OD.Quantity) AS TotalQuantity")
                .From("ORDER_DETAIL OD")
                .InnerJoin("PRODUCT P").On("OD.ProductID = P.ProductID")
                .InnerJoin("[ORDER] O").On("OD.OrderID = O.OrderID")
                .Where("O.OrderStatus = 'Giao hàng thành công'");

            if (!string.IsNullOrEmpty(year))
            {
                if (quy > 0 && quy <= 4)
                {
                    // Xác định khoảng thời gian dựa trên năm và quý
                    DateTime startDate = new DateTime(Convert.ToInt32(year), (quy - 1) * 3 + 1, 1);
                    DateTime endDate = startDate.AddMonths(3).AddDays(-1);
                    sql = sql.Where("O.OrderDate BETWEEN @0 AND @1", startDate, endDate);
                }
                else
                {
                    sql = sql.Where("YEAR(O.OrderDate) = @0", year);
                }
            }

            sql = sql.GroupBy("OD.ProductID, P.ProductName, P.Price");

            var statistics = db.Fetch<ProductStatistics>(sql);
            decimal totalRevenueSql = 0;
            foreach (var product in statistics)
            {
                totalRevenueSql = totalRevenueSql + product.ProductRevenue;
            }
            foreach (var product in statistics)
            {
                product.PercentageRevenue = (product.ProductRevenue / totalRevenueSql) * 100;
            }
            return statistics;
        }
        public static int SumProduct()
        {
            var db = new WebBanBanhConnectionDB();

            int count = db.SingleOrDefault<int>("SELECT COUNT(OrderID) AS NonCancelledOrders FROM [ORDER] WHERE OrderStatus  = 'Giao hàng thành công'");
            if (count > 0)
            {
                return db.SingleOrDefault<int>("SELECT SUM(Quantity) as Sum FROM ORDER_DETAIL OD, [ORDER] O WHERE O.OrderID = OD.OrderID AND OrderStatus = 'Giao hàng thành công'");
            }
            return 0;
        }
        public class ProductStatistics
        {
            public int ProductID { get; set; }
            public string ProductName { get; set; }
            public decimal ProductRevenue { get; set; }
            public decimal Price { get; set; }
            public int TotalQuantity { get; set; }
            public decimal PercentageRevenue { get; set; }
        }

    }
}