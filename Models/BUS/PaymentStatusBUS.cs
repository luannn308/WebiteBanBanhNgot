using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebBanBanhConnection;

namespace WebsiteCakeNew.Models.BUS
{
    public class PaymentStatusBUS
    {
        public static IEnumerable<PAYMENT_STATUS> GetList()
        {
            var db = new WebBanBanhConnectionDB();
            return db.Query<PAYMENT_STATUS>("SELECT * FROM PAYMENT_STATUS");
        }
    }
}