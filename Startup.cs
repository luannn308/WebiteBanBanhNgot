using Microsoft.Owin;
using Owin;

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
