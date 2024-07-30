using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Đồ_án_CNPM
{
    internal class Connect
    {
        SqlConnection con;
        DataSet ds;
        SqlDataAdapter da;
        public Connect()
        {
            string sqlCon = "Data Source = NKD\\NKD; Database = QL_BH; Integrated Security = True";
            con = new SqlConnection(sqlCon);
        }

        public SqlDataReader getDataReader(string sql)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlDataReader rd = cmd.ExecuteReader();

            return rd;
        }

        public DataTable Excute(string sql)
        {
            da = new SqlDataAdapter(sql, con);
            ds = new DataSet();
            da.Fill(ds);
            return ds.Tables[0];
        }

        public void ExcuteNonQuery(string sql)
        {
            SqlCommand cmd = new SqlCommand(sql, con);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }
    }
}
