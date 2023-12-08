using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebBanBanhConnection;

namespace WebsiteCakeNew.Models.BUS
{
    public class ShippingMethodBUS
    {
        public static IEnumerable<ORDER_SHIPPING_METHOD> GetList() {
            var db = new WebBanBanhConnectionDB();
            return db.Query<ORDER_SHIPPING_METHOD>("SELECT * FROM ORDER_SHIPPING_METHOD");
        }
    }
}