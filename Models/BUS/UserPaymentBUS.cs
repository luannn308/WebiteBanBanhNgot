using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebBanBanhConnection;

namespace WebsiteCakeNew.Models.BUS
{
    public class UserPaymentBUS
    {
        private WebBanBanhConnectionDB db;
        public UserPaymentBUS()
        {
            db = new WebBanBanhConnectionDB();
        }
        public IEnumerable<USER_PAYMENT> GetListPaymentByUserID(int userID)
        {
            return db.Query<USER_PAYMENT>("SELECT * From USER_PAYMENT WHERE UserID = @0", userID);
        }
        public USER_PAYMENT GetPaymentById(int id)
        {
            return db.SingleOrDefault<USER_PAYMENT>("SELECT * From USER_PAYMENT WHERE UserPaymentID = @0", id);
        }
        public void UpdatePayment(USER_PAYMENT payment)
        {
            db.Update(payment);
        }
        public void AddPayment(USER_PAYMENT payment)
        {
            // Câu truy vấn SQL INSERT
            string insertQuery = @"INSERT INTO USER_PAYMENT (BankName, CardNumber, DefaultPayment, HolderName, TypeID, UserID) 
                           VALUES (@BankName, @CardNumber, @DefaultPayment, @HolderName, @TypeID, @UserID);";

            // Thực hiện INSERT sử dụng Dapper
            db.Execute(insertQuery, new
            {
                payment.BankName,
                payment.CardNumber,
                payment.DefaultPayment,
                payment.HolderName,
                payment.TypeID,
                payment.UserID
            });
        }

    }
}