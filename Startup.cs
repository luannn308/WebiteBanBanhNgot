using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin;
using Owin;
using WebsiteCakeNew.Models;

[assembly: OwinStartupAttribute(typeof(WebsiteCakeNew.Startup))]
namespace WebsiteCakeNew
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
