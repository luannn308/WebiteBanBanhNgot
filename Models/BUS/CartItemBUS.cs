using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Web;
using WebBanBanhConnection;

namespace WebsiteCakeNew.Models.BUS
{
    public class CartItemBUS
    {
        public static IEnumerable<CART_ITEM> ListCartItemWithShoppingCart(int shoppingCart)
        {
            var db = new WebBanBanhConnectionDB();
            return db.Query<CART_ITEM>("SELECT * FROM CART_ITEM WHERE ShoppingCartID = @0", shoppingCart);
        }
        public static void AddCartItem(CART_ITEM cart)
        {
            var db = new WebBanBanhConnectionDB();
            string sql = "INSERT INTO CART_ITEM (Quantity, Subtotal, ProductID, OrderID, ShoppingCartID) VALUES (@Quantity, @Subtotal, @ProductID, @OrderID, @ShoppingCartID)";
            _ = db.Execute(sql, cart);
        }
        public static void DeleteCartItem(int id)
        {
            var db = new WebBanBanhConnectionDB();
            var cart = db.SingleOrDefault<CART_ITEM>("SELECT * FROM CART_ITEM WHERE CartItemID = @0", id);
            if(cart != null)
            {
                db.Delete(cart);
            }
        }
        public static bool CheckAddedIt(int productId, int shoppingCartId)
        {
            var db = new WebBanBanhConnectionDB();
            var check = db.FirstOrDefault<CART_ITEM>("SELECT * FROM CART_ITEM WHERE ProductID = @0 AND ShoppingCartID = @1",productId,shoppingCartId);
            return check != null;
        }
        public static CART_ITEM GetCartById(int cartId)
        {
            var db = new WebBanBanhConnectionDB();
            var cart = db.SingleOrDefault<CART_ITEM>("SELECT * FROM CART_ITEM WHERE CartItemID = @0", cartId);
            return cart;
        }
        public static void UpdateCartItem(CART_ITEM cartItem)
        {
            var db = new WebBanBanhConnectionDB();
            db.Update(cartItem);
        }
        public static void DeleteByProductID(int id)
        {
            var db = new WebBanBanhConnectionDB();
            db.Execute("DELETE FROM CART_ITEM WHERE ProductID = @0", id);
        }
    }
}