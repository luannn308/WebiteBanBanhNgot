using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebBanBanhConnection;

namespace WebsiteCakeNew.Models.BUS
{
    public class UserShippingBUS
    {
        private WebBanBanhConnectionDB db;
        public UserShippingBUS()
        {
            db = new WebBanBanhConnectionDB();
        }
        public IEnumerable<USER_SHIPPING> GetListShippingByUserID(int userID) {
            return db.Query<USER_SHIPPING>("SELECT * From USER_SHIPPING WHERE UserID = @0", userID);
        }
        public USER_SHIPPING GetFirstShipping(int? userID)
        {
            return db.First<USER_SHIPPING>("SELECT * From USER_SHIPPING WHERE UserID = @0", userID);
        }
        public USER_SHIPPING GetAddressById(int id)
        {
            return db.SingleOrDefault<USER_SHIPPING>("SELECT * From USER_SHIPPING WHERE UserShippingID = @0", id);
        }
        public USER_SHIPPING GetDefaultShippingByUserID(int? userID)
        {
            return db.SingleOrDefault<USER_SHIPPING>("SELECT * From USER_SHIPPING WHERE DefaultShipping = 1 AND UserID = @0", userID);
        }
        public void DeleteAddress(USER_SHIPPING address)
        {
            db.Delete(address);
        }
        public void UpdateAddress(USER_SHIPPING address)
        {
            db.Update(address);
        }
        public void AddShippingUser(USER_SHIPPING us)
        {
            string insertQuery = @"INSERT INTO USER_SHIPPING (Country, City, District, Ward, Street, DefaultShipping, UserID) VALUES (@Country, @City, @District, @Ward, @Street, @DefaultShipping, @UserID);";

            // Thực hiện INSERT sử dụng Dapper
            db.Execute(insertQuery, new
            {
                us.Country,
                us.City,
                us.District,
                us.Ward,
                us.Street,
                us.DefaultShipping,
                us.UserID
            });
        }
    }
}