CREATE DATABASE CAYCANH
GO

USE CAYCANH
GO

CREATE FUNCTION AUTO_IDHHs()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ID VARCHAR(5)
	IF (SELECT COUNT(IDHH) FROM HANGHOA) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(IDHH, 3)) FROM HANGHOA
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'H00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'H0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END

CREATE FUNCTION AUTO_IDNV()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ID VARCHAR(5)
	IF (SELECT COUNT(IDNV) FROM NHANVIEN) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(IDNV, 3)) FROM NHANVIEN
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'NV00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'NV0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END

CREATE FUNCTION AUTO_IDNNK()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ID VARCHAR(5)
	IF (SELECT COUNT(IDNNK) FROM NOINHAPKHAU) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(IDNNK, 3)) FROM NOINHAPKHAU
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'NK00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'NK0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END

CREATE FUNCTION AUTO_IDKH()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ID VARCHAR(5)
	IF (SELECT COUNT(IDKH) FROM KHACHHANG) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(IDKH, 3)) FROM KHACHHANG
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'KH00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'KH0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END


CREATE FUNCTION AUTO_IDGIO()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ID VARCHAR(5)
	IF (SELECT COUNT(IDGIO) FROM GIOHANG) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(IDGIO, 3)) FROM GIOHANG
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'G00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'G0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END


//================================
/*
CREATE FUNCTION AUTO_IDCTPKIEN()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ID VARCHAR(5)
	IF (SELECT COUNT(IDCTPK) FROM CTGIOHANGPK) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(IDCTPK, 3)) FROM CTGIOHANGPK
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'CP0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'CP0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END
*/

/*
CREATE FUNCTION AUTO_IDGPKIEN()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ID VARCHAR(5)
	IF (SELECT COUNT(IDGIOPK) FROM GIOHANGPK) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(IDGIOPK, 3)) FROM GIOHANGPK
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'CP0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'CP0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END

**/

CREATE FUNCTION AUTO_IDLOAI()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ID VARCHAR(5)
	IF (SELECT COUNT(IDLOAI) FROM LOAI) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(IDLOAI, 3)) FROM LOAI
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'L00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'L0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END


CREATE TABLE DANGNHAP
(
	USERNAME NVARCHAR(30) PRIMARY KEY NOT NULL ,
	PASSWORD NVARCHAR(30) NOT NULL,
	GMAIL NVARCHAR(30) NOT NULL,
	PHANQUYEN NVARCHAR(5) NOT NULL,
	IDNV CHAR(5) REFERENCES NHANVIEN(IDNV),
)
GO

CREATE TABLE NHANVIEN
(
	IDNV CHAR(5) PRIMARY KEY CONSTRAINT IDNV DEFAULT DBO.AUTO_IDNV(),
	TENNV NVARCHAR(30) NOT NULL,
	SODT VARCHAR(22) NOT NULL,
	DIACHI NVARCHAR(30) NOT NULL,
	LUONG INT NOT NULL
)
GO

CREATE TABLE NOINHAPKHAU
(
	IDNNK CHAR(5) PRIMARY KEY CONSTRAINT IDNNK DEFAULT DBO.AUTO_IDNNK(),
	TENNNK NVARCHAR(30) NOT NULL,
	DIACHI NVARCHAR(30) NOT NULL,
	SDT VARCHAR(22) NOT NULL
)
GO

CREATE TABLE LOAI
(
	IDLOAI CHAR(5) PRIMARY KEY CONSTRAINT IDLOAICAY DEFAULT DBO.AUTO_IDLOAI(),
	TENLOAI NVARCHAR(20) NOT NULL
)
GO

CREATE TABLE HANGHOA
(
	IDHH CHAR(5) PRIMARY KEY CONSTRAINT IDHH DEFAULT DBO.AUTO_IDHHs(),
	TENHH NVARCHAR(30) NOT NULL,
	SOLUONG INT NOT NULL,
	GIA DECIMAL NOT NULL,
	IDLOAI CHAR(5) REFERENCES LOAI(IDLOAI),
	IDNNK CHAR(5) REFERENCES NOINHAPKHAU(IDNNK)
)
GO

/*
CREATE TABLE PHUKIENCAYCANH
(
	IDPKIEN CHAR(5) PRIMARY KEY CONSTRAINT IDPKIEN DEFAULT DBO.AUTO_IDPKIEN(),
	TENPK NVARCHAR(30) NOT NULL,
	GIA INT NOT NULL,
	SOLUONG INT NOT NULL,
	IDNNK CHAR(5) REFERENCES NOINHAPKHAU(IDNNK) NOT NULL
)
GO
*/

CREATE TABLE KHACHHANG
(
	IDKH CHAR(5) PRIMARY KEY CONSTRAINT IDKH DEFAULT DBO.AUTO_IDKH(),
	TENKH NVARCHAR(30) NOT NULL,
	DIACHI NVARCHAR(30) NOT NULL,
	SDT VARCHAR(22) NOT NULL
)
GO
CREATE TABLE CTGIOHANG
(
	IDGIO CHAR(5) DEFAULT DBO.AUTO_IDGIO(),
	IDHH CHAR(5),
	SOLUONGC INT CHECK(SOLUONGC>0),
	DONGGIA DECIMAL CHECK(DONGGIA>=0),	
	CONSTRAINT CTGIO_PK PRIMARY KEY (IDGIO, IDHH)
)
GO
CREATE TABLE GIOHANG
(
	
	IDGIO CHAR(5) PRIMARY KEY DEFAULT DBO.AUTO_IDGIO(),
	NGAYGIAODICH DATE NOT NULL,
	THANHTIEN DECIMAL CHECK(THANHTIEN>=0) NOT NULL,
	TIENNHAN DECIMAL CHECK(TIENNHAN>=0) NOT NULL,
	TIENTHOI DECIMAL CHECK(TIENTHOI>=0) NOT NULL,
	USERNAME NVARCHAR(30) REFERENCES DANGNHAP(USERNAME),
)
GO
Select * FROM  CTGIOHANG C, GIOHANG CT where C.IDGIO= CT.IDGIO



SELECT * FROM NHANVIEN
SELECT * FROM GIOHANG
INSERT INTO GIOHANG(NGAYGIAODICH,THANHTIEN,TIENNHAN,TIENTHOI,USERNAME) VALUES ('2012/09/01',2200,2200,102000,12)
SELECT * FROM CTGIOHANG
INSERT INTO CTGIOHANG(IDHH,SOLUONGC,DONGGIA) VALUES ('C001',5,1000)
SELECT * FROM DANGNHAP

SELECT * FROM KHACHHANG
SELECT * FROM KHACHHANG

SELECT * FROM LOAI
SELECT * FROM NOINHAPKHAU
SELECT * FROM HANGHOA


Select * FROM  DANGNHAP D, NHANVIEN N WHERE D.IDNV=N.IDNV

Select * FROM  HANGHOA H, LOAI L, NOINHAPKHAU N where H.IDLOAI=L.IDLOAI and H.IDNNK=N.IDNNK

Select * FROM  HANGHOA H, CTGIOHANG CT where H.IDHH= CT.IDHH

select max(IDHH) FROM HANGHOA
select count(IDGIO) FROM GIOHANG
DELETE FROM CTGIOHANG where IDGIO = '';
DELETE FROM GIOHANG where IDGIO = '';

Select * FROM  HANGHOA H, CTGIOHANG CT where H.IDHH= CT.IDHH AND IDGIO = ''

SELECT * FROM GIOHANG WHERE NGAYGIAODICH BETWEEN '2021-05-21' and '2021-05-29'
SELECT NGAYGIAODICH, sum(TIENNHAN) FROM GIOHANG 
SELECT NGAYGIAODICH, SUM(TIENNHAN) FROM GIOHANG