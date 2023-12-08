using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebBanBanhConnection;

namespace WebsiteCakeNew.Models.BUS
{
    public class ShoppingCartBUS
    {
        public static SHOPPING_CART ViewShoppingCartWithUser(int userID)
        {
            var db = new WebBanBanhConnectionDB();
            return db.SingleOrDefault<SHOPPING_CART>("Select * from SHOPPING_CART WHERE UserID = @0", userID);
        }
        public static int CountItemInShoppingCart(int id)
        {
            var db = new WebBanBanhConnectionDB();
            return db.SingleOrDefault<int>("SELECT COUNT(ci.CartItemID) FROM SHOPPING_CART sc LEFT JOIN CART_ITEM ci ON sc.ShoppingCartID = ci.ShoppingCartID WHERE sc.ShoppingCartID = @0 GROUP BY sc.ShoppingCartID", id);
        }
        public static SHOPPING_CART GetByID(int id)
        {
            var db = new WebBanBanhConnectionDB();
            return db.SingleOrDefault<SHOPPING_CART>("SELECT * FROM SHOPPING_CART WHERE ShoppingCartID = @0", id);
        }
    }
}