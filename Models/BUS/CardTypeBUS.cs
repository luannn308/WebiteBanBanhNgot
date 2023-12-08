
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebBanBanhConnection;

namespace WebsiteCakeNew.Models.BUS
{
    public class CardTypeBUS
    {
        private WebBanBanhConnectionDB db;
        public CardTypeBUS()
        {
            db = new WebBanBanhConnectionDB();
        }
        public IEnumerable<CARD_TYPE> GetListCardType()
        {
            return db.Query<CARD_TYPE>("SELECT * From CARD_TYPE");
        }
    }
}