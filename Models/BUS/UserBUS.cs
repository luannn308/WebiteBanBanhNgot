using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using WebBanBanhConnection;

namespace WebsiteCakeNew.Models.BUS
{
    public class UserBUS
    {
        public USER GetItem(string email)
        {
            var db = new WebBanBanhConnectionDB();
            USER u = db.SingleOrDefault<USER>("Select * From [USER] WHERE Email = @0", email);
            return u;
        }
        public int GetIdByUserName(string username)
        {
            var db = new WebBanBanhConnectionDB();
            return db.SingleOrDefault<int>("SELECT [UserID] FROM[QLBB].[dbo].[USER] WHERE[UserName] = @0", username);
        }
        public int Login(string email, string pass)
        {
            var db = new WebBanBanhConnectionDB();
            USER user = db.SingleOrDefault<USER>("SELECT * FROM [USER] WHERE Email = @0", email);
            if (user == null)
            {
                return -1;
            }
            else
            {
                if (user.Password == HashPassword(pass))
                {
                    return 1;
                }
                else
                {
                    return 0;
                }
            }
        }

        public int Register(RegisterViewModel model)
        {
            var db = new WebBanBanhConnectionDB();
            var existingEmailUser = db.SingleOrDefault<USER>("SELECT * FROM [USER] WHERE Email = @0", model.Email);
            if (existingEmailUser != null)
            {
                return -1;
            }
            var existingUsernameUser = db.SingleOrDefault<USER>("SELECT * FROM [USER] WHERE UserName = @0", model.UserName);
            if (existingUsernameUser != null)
            {
                return 0;
            }
            if (!IsPasswordValid(model.Password))
            {
                return -2;
            }
            var user = new USER
            {
                FirstName = model.FirstName,
                LastName = model.LastName,
                Email = model.Email,
                UserName = model.UserName,
                Password = HashPassword(model.Password),
                Telephone = model.Telephone
            };
            // Exclude the ID field to let the database generate the ID automatically
            var sql = "INSERT INTO [USER] (FirstName, LastName, Email, UserName, Password, Telephone) " +
              "VALUES (@FirstName, @LastName, @Email, @UserName, @Password, @Telephone)";

            var result = db.Execute(sql, user);

            if (result <= 0)
            {
                return -2; // User registered successfully
            }
            return 1;
        }
        public void SetRoleUser(string username)
        {
            var userBus = new UserBUS();
            var roleBus = new RoleBUS();
            USER_ROLE u_r = new USER_ROLE();
            u_r.RoleID = roleBus.GetIdByRoleName("User");
            u_r.UserID = userBus.GetIdByUserName(username);
            var db = new WebBanBanhConnectionDB();
            db.Insert(u_r);
        }
        public string GetRoleUser(int id)
        {
            var db = new WebBanBanhConnectionDB();
            var userRole = db.SingleOrDefault<USER_ROLE>("SELECT * FROM [USER_ROLE] WHERE UserID = @0", id);
            if (userRole != null)
            {
                var role = db.SingleOrDefault<ROLE>("SELECT * FROM [ROLE] WHERE RoleID = @0", userRole.RoleID);
                if (role != null)
                {
                    return role.RoleName;
                }
            }
            return string.Empty;
        }
        public bool IsPasswordValid(string password)
        {
            // Kiểm tra mật khẩu phải có ít nhất một chữ thường, một chữ hoa và một số
            var regex = new Regex(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$");
            return regex.IsMatch(password);
        }
        public string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder stringBuilder = new StringBuilder();
                for (int i = 0; i < hashedBytes.Length; i++)
                {
                    stringBuilder.Append(hashedBytes[i].ToString("x2"));
                }
                return stringBuilder.ToString();
            }
        }
    }
}