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
        public IEnumerable<USER> GetList()
        {
            var db = new WebBanBanhConnectionDB();
            return db.Query<USER>("SELECT * FROM [USER]");
        }
        public USER GetItem(string email)
        {
            var db = new WebBanBanhConnectionDB();
            USER u = db.SingleOrDefault<USER>("Select * From [USER] WHERE Email = @0", email);
            if(u == null)
            {
                u = db.SingleOrDefault<USER>("Select * From [USER] WHERE Username = @0", email);
            }
            return u;
        }
        public static int CountUser()
        {
            var db = new WebBanBanhConnectionDB();
            return db.SingleOrDefault<int>("SELECT COUNT(U.UserID) AS UserCount FROM [USER] U JOIN USER_ROLE UR ON U.UserID = UR.UserID JOIN ROLE R ON UR.RoleID = R.RoleID WHERE R.RoleName = 'User';");
        }
        public int GetIdByUserName(string username)
        {
            var db = new WebBanBanhConnectionDB();
            return db.SingleOrDefault<int>("SELECT [UserID] FROM[QLBB].[dbo].[USER] WHERE[UserName] = @0", username);
        }
        public static USER GetById(int? id)
        {
            var db = new WebBanBanhConnectionDB();
            return db.SingleOrDefault<USER>("SELECT * FROM[QLBB].[dbo].[USER] WHERE [UserID] = @0", id);
        }
        public int Login(string username, string pass)
        {
            var db = new WebBanBanhConnectionDB();
            USER user = db.SingleOrDefault<USER>("SELECT * FROM [USER] WHERE Email = @0", username);
            if (user == null)
            {
                user = db.SingleOrDefault<USER>("SELECT * FROM [USER] WHERE Username = @0", username);

            }
            if(user != null)
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
            else
            {
                return -1;
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
        public void CreateShoppingCart(string username)
        {
            var userBus = new UserBUS();
            SHOPPING_CART sc = new SHOPPING_CART();
            sc.UserID = userBus.GetIdByUserName(username);
            var db = new WebBanBanhConnectionDB();
            db.Insert(sc);
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
            var regex = new Regex(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$");
            return regex.IsMatch(password);
        }
        public bool IsEmailValid(string email)
        {
            var emailRegex = new Regex(@"^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
            return emailRegex.IsMatch(email);
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
        public int AddUser(USER user)
        {
            var db = new WebBanBanhConnectionDB();
            var existingEmailUser = db.SingleOrDefault<USER>("SELECT * FROM [USER] WHERE Email = @0", user.Email);
            if (existingEmailUser != null)
            {
                return -1;
            }
            var existingUsernameUser = db.SingleOrDefault<USER>("SELECT * FROM [USER] WHERE UserName = @0", user.UserName);
            if (existingUsernameUser != null)
            {
                return 0;
            }
            if (!IsPasswordValid(user.Password))
            {
                return -2;
            }
            if (!IsEmailValid(user.Email))
            {
                return -3;
            }
            var userNew = new USER
            {
                FirstName = user.FirstName,
                LastName = user.LastName,
                Email = user.Email,
                UserName = user.UserName,
                Password = HashPassword(user.Password),
                Telephone = user.Telephone
            };
            var sql = "INSERT INTO [USER] (FirstName, LastName, Email, UserName, Password, Telephone) " +
              "VALUES (@FirstName, @LastName, @Email, @UserName, @Password, @Telephone)";

            var result = db.Execute(sql, userNew);

            if (result <= 0)
            {
                return -2;
            }
            return 1;
        }
        public void DeleteUser(int id)
        {
            var db = new WebBanBanhConnectionDB();
            db.Execute("DELETE FROM [USER_ROLE] WHERE UserID = @0", id);
            db.Execute("UPDATE [ORDER] SET UserID = null  WHERE UserID = @0", id);
            db.Execute("DELETE FROM [SHOPPING_CART] WHERE UserID = @0", id);
            db.Execute("DELETE FROM [USER_SHIPPING] WHERE UserID = @0", id);
            var user = db.SingleOrDefault<USER>("SELECT * FROM [USER] WHERE UserID = @0", id);
            if (user != null)
            {
                db.Execute("DELETE FROM [USER] WHERE UserID = @0", user.UserID);
            }
        }
        public int UpdateUser(int id, USER u, int roleID)
        {
            var db = new WebBanBanhConnectionDB();
            var existingEmailUser = db.SingleOrDefault<USER>("SELECT * FROM [USER] WHERE Email = @0", u.Email);
            if (existingEmailUser != null && existingEmailUser.UserID != id)
            {
                return -1;
            }
            var existingUsernameUser = db.SingleOrDefault<USER>("SELECT * FROM [USER] WHERE UserName = @0", u.UserName);
            if (existingUsernameUser != null && existingUsernameUser.UserID != id)
            {
                return 0;
            }
            if (!IsEmailValid(u.Email))
            {
                return -2;
            }
            db.Execute("DELETE FROM USER_ROLE WHERE UserID = @0", id);
            USER_ROLE userRole = new USER_ROLE
            {
                UserID = id,
                RoleID = roleID
            };
            User_RoleBUS.AddUserRole(userRole);
            db.Execute("UPDATE [USER] SET FirstName = @0, LastName = @1, Email = @2, Telephone = @3, Username = @4 WHERE UserID = @5;", u.FirstName, u.LastName,u.Email,u.Telephone, u.UserName, id);
            return 1;
        }
    }
}