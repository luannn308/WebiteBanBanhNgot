using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using WebsiteCakeNew.Models.BUS;

namespace WebsiteCakeNew.App_Start
{
    public class RoleUser: AuthorizeAttribute
    {
        public override void OnAuthorization(AuthorizationContext filterContext)
        {
            var user = SessionConfig.GetUser();
            var db = new UserBUS();
            if (user == null || db.GetRoleUser(user.UserID) != "Administrator")
            {
                filterContext.Result = new RedirectToRouteResult(new RouteValueDictionary( new
                {
                    Controller = "../Home",
                    Action = "Index",
                }
                ));
            }
        }
    }
}