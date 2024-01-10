using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebBanBanhConnection;

namespace WebsiteCakeNew.Models.BUS
{
    public class OrderStatusBUS
    {
        public static IEnumerable<ORDER_STATUS> GetList()
        {
            var db = new WebBanBanhConnectionDB();
            return db.Query<ORDER_STATUS>("SELECT * FROM ORDER_STATUS");
        }
    }
}