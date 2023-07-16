using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebBanBanhConnection;

namespace WebsiteCakeNew.Models.BUS
{
    public class RoleBUS
    {
        public int GetIdByRoleName(string role)
        {
            var db = new WebBanBanhConnectionDB();
            return db.SingleOrDefault<int>("SELECT [RoleID] FROM[QLBB].[dbo].[ROLE] WHERE[RoleName] = @0", role);
        }
    }
}