using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Đồ_án_CNPM
{
    
    internal class KhachHang
    {
        Connect db;

        public KhachHang()
        {
            db = new Connect();
        }
        public DataTable LayDSKH()
        {
            string sql = "Select * from KHACHHANG";
            DataTable dt = db.Excute(sql);
            return dt;
        }
    }
}
