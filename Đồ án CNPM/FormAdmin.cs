using Đồ_án_CNPM.UC_Controls;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Đồ_án_CNPM
{
    public partial class FormAdmin : Form
    {
        private void addUserControl(UserControl userControl)
        {
            userControl.Dock = DockStyle.Fill;
            main.Controls.Clear();
            main.Controls.Add(userControl);
            userControl.BringToFront();

        }
        public FormAdmin()
        {
            InitializeComponent();
            UC_Kho uc = new UC_Kho();
            addUserControl(uc);
            this.SetStyle(ControlStyles.ResizeRedraw, true);
        }
        private const int cGrip = 16;
        private const int cCaption = 32;
        protected override void WndProc(ref Message m)
        {
            if(m.Msg==0x84)
            {
                Point pos= new Point(m.LParam.ToInt32());
                pos=this.PointToClient(pos);
                if(pos.Y < cCaption)
                {
                    m.Result = (IntPtr)2;
                    return;
                }
                if(pos.X>=this.ClientSize.Width - cGrip && pos.Y >= this.ClientSize.Height -cGrip)
                {
                    m.Result= (IntPtr)17;
                    return;
                }
            }
            base.WndProc(ref m);

        }
        private void rdoKho_Click(object sender, EventArgs e)
        {
            UC_Kho uc = new UC_Kho();
            addUserControl(uc);
        }

        private void rdoNhapHang_Click(object sender, EventArgs e)
        {
            UC_NhapHang uc=new UC_NhapHang();
            addUserControl(uc);
        }

        private void rdoHoaDon_Click(object sender, EventArgs e)
        {
            UC_HoaDon uc=new UC_HoaDon();
            addUserControl(uc);
        }
        private void btnKH_Click(object sender, EventArgs e)
        {
            UC_KhachHang uc = new UC_KhachHang();
            addUserControl(uc);
        }

        private void picAdmin_Click(object sender, EventArgs e)
        {
            UC_Admin uc=new UC_Admin();
            addUserControl(uc);
        }
    }
}
