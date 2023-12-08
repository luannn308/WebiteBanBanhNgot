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
    }
}