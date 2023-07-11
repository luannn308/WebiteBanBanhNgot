using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebsiteCakeNew.Models
{
    public class Product
    {
        public int ProductID { get; set; }
        public string ProductName { get; set; }
        public string Description { get; set; }
        public string ShortDescription { get; set; }
        public int? StockNumber { get; set; }
        public string Image { get; set; }
        public float Price { get; set; }
        public int Discount { get; set; }
        public float Rating { get; set; }
        public DateTime PublicationDate { get; set; }
    }

}