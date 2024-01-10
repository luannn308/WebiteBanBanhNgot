using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebBanBanhConnection;

namespace WebsiteCakeNew.App_Start
{
    public static class SessionConfig
    {
        public static void SetUser(USER user)
        {
            HttpContext.Current.Session["user"] = user;
        }
        public static USER GetUser()
        {
           return (USER)HttpContext.Current.Session["user"];
        }
    }
}