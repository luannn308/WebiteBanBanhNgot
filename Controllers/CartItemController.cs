using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanBanhConnection;
using WebsiteCakeNew.Models;
using WebsiteCakeNew.Models.BUS;

namespace WebsiteCakeNew.Controllers
{
    public class CartItemController : Controller
    {
        // GET: CartItem
        public ActionResult Index()
        {
            return View();
        }
        [HttpPost]
        public ActionResult AddToCart(int productId, int shoppingCartId, int quantity)
        {
            var product = ShopBUS.ChiTiet(productId);

            if (product != null)
            {
                var cartItem = new CART_ITEM
                {
                    Quantity = quantity,
                    ProductID = productId,
                    ShoppingCartID = shoppingCartId
                };
                CartItemBUS.AddCartItem(cartItem);
                return Json(new { success = true, message = "Sản phẩm đã được thêm vào giỏ hàng" });
            }

            return Json(new { success = false, message = "Không tìm thấy sản phẩm" });
        }
        [HttpPost]
        public ActionResult DeleteCartItem(int cartId)
        {
            var cart = CartItemBUS.GetCartById(cartId);
            if (cart != null)
            {
                CartItemBUS.DeleteCartItem(cartId);
                return Json(new { success = true, message = "Đã xoá khỏi giỏ hàng" });
            }

            return Json(new { success = false, message = "Không xoá được" });
        }
        [HttpPost]
        public ActionResult UpdateCartItemQuantity(int cartItemId, int newQuantity)
        {
            var cartItem = CartItemBUS.GetCartById(cartItemId);
            if (cartItem != null)
            {
                cartItem.Quantity = newQuantity;
                CartItemBUS.UpdateCartItem(cartItem);
                return Json(new { success = true, message = "Số lượng sản phẩm đã được cập nhật" });
            }

            return Json(new { success = false, message = "Không cập nhật được số lượng sản phẩm" });
        }

    }
}