using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Đồ_án_CNPM
{
    public partial class DangNhap : Form
    {
        Connect db = new Connect();
        public DangNhap()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        bool login()
        {


            string username = txtTaiKhoan.Text;
            string password = txtMatKhau.Text;

            string query = "select * from dbo.ACCOUNT_USER where USERNAME=N'" + username + "'" + "and PASS=N'" + password + "'";
            SqlDataReader data = db.getDataReader(query);

            if (data.Read() == true)
            {
                return true;
            }

            return false;
        }

        private void btnDangNhap_Click(object sender, EventArgs e)
        {

            if (login())
            {
                MessageBox.Show("Đăng nhập thành công");
                Hide();
                //frmMain F = new frmMain(txtUser.Text);
                //F.ShowDialog();
                //this.Show();
                //txtUser.Clear();
                //txtPASSWORD.Clear();
                //txtUser.Focus();
            }
            else
            {
                MessageBox.Show("Sai Tài Khoản Hoặc Mật Khẩu!!!");
               
            }
        }

        private void btnHuy_Click(object sender, EventArgs e)
        {
            txtTaiKhoan.Clear();
            txtMatKhau.Clear();
            txtTaiKhoan.Focus();
        }
    }
}
