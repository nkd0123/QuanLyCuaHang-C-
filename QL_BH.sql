use master 
drop database QL_BH

CREATE DATABASE QL_BH
GO

USE QL_BH
GO


--================================== KHÁCH HÀNG ======================================
CREATE TABLE KHACHHANG
(
	MAKH CHAR(10) PRIMARY KEY,
	HOTEN NVARCHAR(100),
	DIACHI NVARCHAR(100),
    EMAIL NVARCHAR(50) UNIQUE,
	
    SDT CHAR(12) UNIQUE
)
--==================================================================================



--================================== NHÂN VIÊN ======================================
CREATE TABLE NHANVIEN
(
	MANV CHAR(10) PRIMARY KEY,
	HOTEN NVARCHAR(100),
	DIACHI NVARCHAR(100),
	SDT CHAR (12),
	NGAYSINH DATE
)
--==================================================================================



--================================== NHÀ CUNG CẤP ======================================
CREATE TABLE NHACC
(
	MANCC CHAR(10) PRIMARY KEY,
	TENNCC NVARCHAR(100),
	DCHI NVARCHAR(80)
)
--==================================================================================



--================================== LOẠI SẢN PHẨM ================================
CREATE TABLE LOAI
(
	MALOAI CHAR(10) PRIMARY KEY,
	TENLOAI NVARCHAR(100)
)
 
--==================================================================================



--================================== SẢN PHẨM ======================================
CREATE TABLE SANPHAM
(
	MASP CHAR (10) PRIMARY KEY,
	TENSP NVARCHAR(100),
	DVT NVARCHAR(20),
	DONGIA MONEY,
	MALOAI CHAR(10)
)
ALTER TABLE SANPHAM
ADD CONSTRAINT FK_SP_LOAI FOREIGN KEY (MALOAI) REFERENCES LOAI(MALOAI)
--sản phẩm được phân loại. Ví dụ: Kem có các sản phẩm thuộc loại kem, Kẹo....
--====================================================================================


--================================== KHO ======================================
CREATE TABLE KHO
(
	MASP CHAR(10) PRIMARY KEY,
	TENSP CHAR(100),
	SOLUONG INT,
	CONSTRAINT FK_KHO_SP FOREIGN KEY(MASP) REFERENCES SANPHAM(MASP)
)
--==============================================================================



--=================================== HÓA ĐƠN ========================================
--Hóa đơn
CREATE TABLE HOADON
(
	SOHD CHAR (10) PRIMARY KEY,
	NGAYLAP DATE,
	MAKH CHAR(10),
	MANV CHAR(10),
	TINHTRANG CHAR(20)
)
ALTER TABLE HOADON
ADD CONSTRAINT FK_HD_KH FOREIGN KEY (MAKH) REFERENCES KHACHHANG(MAKH)

ALTER TABLE HOADON
ADD CONSTRAINT FK_HD_NV FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV)


--Chi tiết hóa đơn
CREATE TABLE CHITIET_HD
(
	SOHD CHAR(10),
	MASP CHAR(10),
	SOLUONG INT,
	DONGIA MONEY,
	THANHTIEN MONEY
	CONSTRAINT PK_CTHD PRIMARY KEY (SOHD,MASP)
)
ALTER TABLE CHITIET_HD
ADD CONSTRAINT FK_CHITIET_HD_HD FOREIGN KEY (SOHD) REFERENCES HOADON(SOHD)

ALTER TABLE CHITIET_HD
ADD CONSTRAINT FK_CHITIET_HD_SP FOREIGN KEY (MASP) REFERENCES SANPHAM(MASP)
--====================================================================================


--=================================== NHẬP HÀNG ======================================
CREATE TABLE NHAPHANG
(
   PHIEU CHAR(10) PRIMARY KEY,
   NGAYNHAP DATE,
   MANV CHAR(10),
   MANCC CHAR(10),
   TONGTHANHTIEN MONEY,
   CONSTRAINT FK_NHAPHANG_NCC FOREIGN KEY (MANCC) REFERENCES NHACC(MANCC),
   CONSTRAINT FK_NHAPHANG_NHANVIEN FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV)
)

CREATE TABLE CHITIET_NH
(
   PHIEU CHAR(10),
   MASP CHAR(10),
   SOLUONG INT,
   DONGIA MONEY,
   THANHTIEN MONEY,
   CONSTRAINT PK_CHITIET_NH PRIMARY KEY (PHIEU, MASP),
   CONSTRAINT FK_CHITIET_NH_NHAPXUATKHO FOREIGN KEY (PHIEU) REFERENCES NHAPHANG(PHIEU),
   CONSTRAINT FK_CHITIET_NH_KHO FOREIGN KEY (MASP) REFERENCES KHO(MASP)
)
--===================================================================================



--================================== TÀI KHOẢN ======================================
--User đăng ký/Đăng nhập
--Khi đăng ký kết hợp 2 bảng KHACHHANG và ACCOUNT_USER
CREATE TABLE ACCOUNT_USER
(
    ID INT PRIMARY KEY IDENTITY(1,1),
	USERNAME VARCHAR(40) UNIQUE,
	PASS VARCHAR(40),
	MAKH CHAR(10),
	CONSTRAINT FK_ACC_KH FOREIGN KEY (MAKH) REFERENCES KHACHHANG(MAKH)
)



select * from ACCOUNT_USER
--ADMIN không cần đăng ký tài khoản, Đăng nhập trực tiếp
CREATE TABLE ACCOUNT_ADMIN
(
    ID INT PRIMARY KEY,
    USERNAME NVARCHAR(50) UNIQUE,
    PASS NVARCHAR(50)
) 




SELECT *FROM ACCOUNT_ADMIN
--===================================================================================

--NOTE: Mỗi bảng KHO chứ số lượng của sản phẩm còn tồn
--khi nhập hàng thì số lượng tồn trong kho tự động tăng
--Khi thanh toán hóa đơn thì số lượng tồn trong kho tự động giảm
--1 nhân viên có thể xử lí hóa đơn hoặc xử lý nhập hàng
--Tự động cập nhật lại thành tiền trong bảng HOADON, NHAPHANG


------------------------
insert into LOAI
values
('L001','laoi1'),
insert into LOAI
values
('L002','laoi2'),
('L003','laoi3')

insert into SANPHAM
Values 
('SP01',N'Banh orio',N'bich',2000,'L001'),
('SP02',N'My hao hao',N'bich',2420,'L001')

insert into SANPHAM
Values 
('SP03',N'bO GIAT OMO',N'bich',20040,'L002'),
('SP04',N'COCA',N'CHAI',20050,'L003')

SELECT * FROM SANPHAM WHERE TENSP LIKE '%COCA'

insert into CHITIET_HD
values
('HD001',	

insert into ACCOUNT_ADMIN
values 
(1,'ADMINTEST1','abc'),
(2,'ADMINTEST2','aaa'),
(3,'ADMINTEST3','ccc')

insert into ACCOUNT_USER
values 
('USERTEST1','abc',null),
('USERTEST2','aaa',null),
('USERTEST3','ccc',null)

insert into KHACHHANG
values
('KH001',N'Nguyễn Văn A',N'140 Lê Trọng Tấn','abc@gmail.com','0123443789'),
('KH002',N'Nguyễn Văn B',N'1401 Lê Trọng Tấn','abc1@gmail.com','0125456789'),
('KH003',N'Nguyễn Văn C',N'1402 Lê Trọng Tấn','abc2@gmail.com','01234563489'),
('KH004',N'Nguyễn Văn D',N'1403 Lê Trọng Tấn','abc3@gmail.com','01235456789'),
('KH005',N'Nguyễn Văn E',N'1404 Lê Trọng Tấn','abc4@gmail.com','01234565689')
		

select * from KHACHHANG

--==================================Trigger==============================
--khi nhập hàng thì số lượng tồn trong kho tự động tăng
GO
CREATE TRIGGER CapNhat_NhapHang_SL_Kho
ON NHAPHANG
AFTER INSERT
AS
BEGIN
    -- Lấy thông tin về sản phẩm và số lượng nhập hàng từ bảng CHITIET_NH
    DECLARE @MASP INT, @SOLUONG INT;
    SELECT @MASP = MASP, @SOLUONG = SOLUONG FROM CHITIET_NH WHERE PHIEU IN (SELECT PHIEU FROM inserted);

    -- Kiểm tra xem sản phẩm đã tồn tại trong bảng KHO hay chưa
    IF EXISTS (SELECT 1 FROM KHO WHERE MASP = @MASP)
    BEGIN
        -- Cập nhật số lượng tồn của sản phẩm trong bảng KHO
        UPDATE KHO
        SET SOLUONG = SOLUONG + @SOLUONG
        WHERE MASP = @MASP;
    END
    ELSE
    BEGIN
        -- Thêm mới sản phẩm vào bảng KHO nếu chưa tồn tại
        INSERT INTO KHO (MASP, SOLUONG)
        VALUES (@MASP, @SOLUONG);
    END
END



--Khi thanh toán hóa đơn thì số lượng tồn trong kho tự động giảm
GO
CREATE TRIGGER CapNhat_ThanhToan_SL_Kho
ON HOADON
AFTER UPDATE
AS
BEGIN
    -- Kiểm tra xem hóa đơn đã được thanh toán hay chưa
    IF UPDATE(TINHTRANG) AND EXISTS (SELECT 1 FROM inserted WHERE TINHTRANG = 'Đã thanh toán')
    BEGIN
        -- Lấy thông tin về sản phẩm và số lượng bán từ bảng CHITIET_HD
        DECLARE @MASP INT, @SOLUONG INT;
        SELECT @MASP = MASP, @SOLUONG = SOLUONG FROM CHITIET_HD WHERE SOHD IN (SELECT SOHD FROM inserted);

        -- Kiểm tra xem sản phẩm có tồn tại trong bảng KHO hay không
        IF EXISTS (SELECT 1 FROM KHO WHERE MASP = @MASP)
        BEGIN
            -- Cập nhật số lượng tồn của sản phẩm trong bảng KHO
            UPDATE KHO
            SET SOLUONG = SOLUONG - @SOLUONG
            WHERE MASP = @MASP;
        END
    END
END



--Tự động cập nhật lại thành tiền trong bảng HOADON, NHAPHANG
GO
CREATE TRIGGER Update_ThanhTien_HOADON
ON CHITIET_HD
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        -- Cập nhật lại thành tiền cho các hóa đơn được thêm, sửa hoặc xóa trong bảng CHITIET_HD
        UPDATE HOADON
        SET TONGTHANHTIEN = (SELECT SUM(THANHTIEN) FROM CHITIET_HD WHERE CHITIET_HD.SOHD = HOADON.SOHD)
        WHERE SOHD IN (SELECT SOHD FROM inserted)
    END
END
GO

CREATE TRIGGER Update_ThanhTien_NHAPHANG
ON CHITIET_NH
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        -- Cập nhật lại thành tiền cho các phiếu nhập hàng được thêm, sửa hoặc xóa trong bảng CHITIET_NH
        UPDATE NHAPHANG
        SET TONGTHANHTIEN = (SELECT SUM(THANHTIEN) FROM CHITIET_NH WHERE CHITIET_NH.PHIEU = NHAPHANG.PHIEU)
        WHERE PHIEU IN (SELECT PHIEU FROM inserted)
    END
END
GO