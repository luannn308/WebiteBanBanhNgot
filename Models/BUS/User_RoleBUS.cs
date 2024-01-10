using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebBanBanhConnection;

namespace WebsiteCakeNew.Models.BUS
{
    public class User_RoleBUS
    {
        public static void AddUserRole(USER_ROLE ur)
        {
            var db = new WebBanBanhConnectionDB();
            db.Insert(ur);
        }
    }
}