using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Security.Cryptography;
using System.Text;
using System.Security.Cryptography.X509Certificates;
using System.IO;
using System.Collections;



namespace com.sinapay
{
/// <summary>
/// weibopayapi
/// </summary>
public class weibopayapi
{
    public weibopayapi()
    {
    }
    /// <summary>
    /// 把数组所有元素，按照“参数=参数值”的模式用“&”字符拼接成字符串
    /// </summary>
    /// <param name="sArray">需要拼接的数组</param>
    /// <returns>拼接完成以后的字符串</returns>
    public static string concat_string(SortedList<string, string> dic_array)
    {
        StringBuilder prestr = new StringBuilder();
        foreach (KeyValuePair<string, string> temp in dic_array)
        {
            if (temp.Value != null && temp.Value != "" && temp.Key !="sign_type"&&temp.Key !="sign_version"&&temp.Key !="sign")
            {
            prestr.Append(temp.Key.ToString().Trim()+"="+temp.Value.ToString().Trim()+"&");
            }
        }
       //去掉最後一個&字符
        int nLen = prestr.Length;
        prestr.Remove(nLen - 1, 1);
        return prestr.ToString();
    }
    public static string MD5File(string fileName)
    {
        //return HashFile(fileName, "md5");
        return GetMD5HashFromFile(fileName);
    }
    public static string send_url(SortedList<string, string> dic_array)
    {
        StringBuilder prestr = new StringBuilder();
        foreach (KeyValuePair<string, string> temp in dic_array)
        {
            prestr.Append(temp.Key + "=" + HttpUtility.UrlEncode(HttpUtility.UrlEncode(temp.Value)) + "&");
        }

        //去掉最後一個&字符
        int nLen = prestr.Length;
        prestr.Remove(nLen - 1, 1);

        return prestr.ToString();
    }
    /// <summary>
    /// Check_SignMsg 数据返回签名校验
    /// </summary>
    /// <param name="para_list">新浪支付返回数据</param>
    /// <param name="SignType">新浪支付返回的签名类型</param>
    /// <param name="signMsg">新浪支付随数据返回的签名</param>
    /// <param name="charset">编码类型</param>
    /// <param name="logs">日志类</param>
    /// <returns>bool  true or false</returns>
    public static bool  Check_SignMsg(SortedList<string, string> para_list, string SignType,string signMsg,string charset,LogClass logs)
    {
        //把数组所有元素，按照“参数=参数值”的模式用“&”字符拼接成字符串
        string data = concat_string(para_list);
        //把最终的字符串签名，获得签名结果
        bool mysign;
        switch (SignType)
        {
            case "MD5":
                mysign = MD5_Sign(data) == signMsg ? true : false;
                break;
            default:
                //原本key地址应放在Check_SignMsg
                mysign = RSA_VerifySign(data.ToString().Trim(), signMsg.ToString().Trim(), charset);
                break;
        }
        logs.WriteLogFile("用于验证签名的data字符串是：" + data + "\n 校验的签名值是：" + signMsg + "\n 校验的结果是：" + mysign);
        return mysign;
    }
   /// <summary>
   /// 对提交数据进行加签
   /// </summary>
   /// <param name="para_list">需要加签数据</param>
   /// <param name="SignType">加签类型</param>
   /// <returns>string 签名value</returns>
    public static string GetSignMsg(LogClass logs,SortedList<string, string> para_list, string SignType)
    {
        //把数组所有元素，按照“参数=参数值”的模式用“&”字符拼接成字符串
        string data = concat_string(para_list);
        //把最终的字符串签名，获得签名结果
        string mysign = "";
        switch (SignType)
        {
            case "MD5"://MD5
                mysign = MD5_Sign(data);
                break;
            default:
                mysign = RSA_Sign(data);
                break;
        }
        logs.WriteLogFile("用于计算签名的字符串为：" + data + "\n 计算出来的签名结果为：" + mysign);
        return mysign;
    }
		 /// <summary>
		 /// MD5 签名方法
		 /// </summary>
		 /// <param name="in_str">签名数据</param>
		 /// <returns></returns>
        public static string MD5_Sign(string in_str)
        {
            MD5 myMD5 = new MD5CryptoServiceProvider();
            byte[] signed = myMD5.ComputeHash(Encoding.GetEncoding("utf-8").GetBytes(in_str));
            return byte2mac(signed);
        }
   /// <summary>
   /// MD5签名转string
   /// </summary>
   /// <param name="signed"></param>
   /// <returns></returns>
        public static string byte2mac(byte[] signed)
        {
            StringBuilder EnText = new StringBuilder();
            foreach (byte Byte in signed)
            {
                EnText.AppendFormat("{0:x2}", Byte);
            }
            return EnText.ToString();

        }
       
    /// <summary>
    /// RSA验签
    /// </summary>
    /// <param name="dataStr">验签数据</param>
    /// <param name="signStr">随数据签名</param>
    /// <param name="charset">编码l类型</param>
    /// <returns>boos true or false</returns>
        public static bool RSA_VerifySign(string content, string signedString, string charset)
        {
            string pubKey = ReadKeyFile(sinapay_config.Sign_public_key);
            RSAParameters para = ConvertFromPemPublicKey(pubKey);
            RSACryptoServiceProvider rsa = new RSACryptoServiceProvider();
            rsa.ImportParameters(para);

            //X509Certificate2 publicCer = new X509Certificate2(sinapay_config.Sign_public_key);
            //var rsaCrypto = (RSACryptoServiceProvider) publicCer.PublicKey.Key;
            SHA1CryptoServiceProvider sh = new SHA1CryptoServiceProvider();
            ////对签名数据进行转码
            byte[] dataBytes = Encoding.GetEncoding(charset).GetBytes(content);
            ////对签名进行解码
            byte[] signBytes = Convert.FromBase64String(signedString);
            ////对签名进行check
            //bool result = rsaCrypto.VerifyData(dataBytes,sh,signBytes);

            return rsa.VerifyData(dataBytes,sh,signBytes);
        }
        private static RSAParameters ConvertFromPublicKey(string p)
        {
            throw new NotImplementedException();
        }
    /// <summary>
    /// RSA 加签
    /// </summary>
    /// <param name="dataStr">加签数据</param>
    /// <returns>base64编码后的签名</returns>
        public static string RSA_Sign(string dataStr)
        {
            string privete_key = ReadKeyFile(sinapay_config.Sign_private_key);
            RSACryptoServiceProvider rsa = ConvertFromPemPrivate_Key(privete_key);
            SHA1 sh = new SHA1CryptoServiceProvider();
            byte[] dataBytes = Encoding.GetEncoding("utf-8").GetBytes(dataStr);
            byte[] signBytes = rsa.SignData(dataBytes, sh);
            return Convert.ToBase64String(signBytes);
        }
        /// <summary>
        /// RSA OPENSSL加密
        /// </summary>
        /// <param name="content">需要加密的数据 string类型</param>
        /// <returns>加密后的base64转码数据</returns>
        public static String RSA_PEM_Encrypt(String content)
        {
            string pubKey = ReadKeyFile(sinapay_config.Public_key);
            RSAParameters para = ConvertFromPemPublicKey(pubKey);
            RSACryptoServiceProvider rsa = new RSACryptoServiceProvider();
            rsa.ImportParameters(para);
            byte[] dataBytes = Encoding.GetEncoding("utf-8").GetBytes(content);
            byte[] resultBytes = rsa.Encrypt(dataBytes, false);
            String result = Convert.ToBase64String(resultBytes);
            return result;
        }
        /// <summary>
        /// RSA openssl PEM格式秘钥解密
        /// </summary>
        /// <param name="content">需要解密的数据</param>
        /// <returns>解密后的数据</returns>
        public static String RSA_PEM_Decrypter(String content)
        {
            string privatekey = ReadKeyFile(sinapay_config.Private_key);
            RSAParameters para = ConvertFromPemPrivateKey(privatekey);
            RSACryptoServiceProvider rsa = new RSACryptoServiceProvider();
            rsa.ImportParameters(para);
            byte[] data = Convert.FromBase64String(content);
            byte[] resultBytes = rsa.Decrypt(data, false);
            String reuslt = Encoding.UTF8.GetString(resultBytes);
            return reuslt;
        }
    /// <summary>
    /// 读取秘钥文件
    /// </summary>
    /// <param name="path">秘钥文件地址</param>
    /// <returns>秘钥内容</returns>
        public static string ReadKeyFile(string path)
        {
            StreamReader reader = new StreamReader(path);
            
            string key = reader.ReadToEnd();
            reader.Close();
            return key;
        }
     /// <summary>
        /// 将pem格式私钥(1024 or 2048)转换为RSAParameters
        /// </summary>
        /// <param name="pemFileConent">pem私钥内容</param>
        /// <returns>转换得到的RSAParamenters</returns>
        public static RSACryptoServiceProvider ConvertFromPemPrivate_Key(string pemFileConent)
        {
            if (string.IsNullOrEmpty(pemFileConent))
            {
                throw new ArgumentNullException("pemFileConent", "This arg cann't be empty.");
            }
            pemFileConent = pemFileConent.Replace("-----BEGIN PRIVATE KEY-----", "").Replace("-----END PRIVATE KEY-----", "").Replace("\n", "").Replace("\r", "");
            byte[] keyData = Convert.FromBase64String(pemFileConent);

            return DecodePrivateKeyInfo(keyData);
        }
        /// <summary>
        /// 将pem格式私钥(1024 or 2048)转换为RSAParameters
        /// </summary>
        /// <param name="pemFileConent">pem私钥内容</param>
        /// <returns>转换得到的RSAParamenters</returns>
        public static RSAParameters ConvertFromPemPrivateKey(string pemFileConent)
        {
            if (string.IsNullOrEmpty(pemFileConent))
            {
                throw new ArgumentNullException("pemFileConent", "This arg cann't be empty.");
            }
            pemFileConent = pemFileConent.Replace("-----BEGIN RSA PRIVATE KEY-----", "").Replace("-----END RSA PRIVATE KEY-----", "").Replace("\n", "").Replace("\r", "");
            byte[] keyData = Convert.FromBase64String(pemFileConent);

            bool keySize1024 = (keyData.Length == 609 || keyData.Length == 610);
            bool keySize2048 = (keyData.Length == 1190 || keyData.Length == 1192);

            if (!(keySize1024 || keySize2048))
            {
             //   throw new ArgumentException("pem file content is incorrect, Only support the key size is 1024 or 2048");
            }

            int index = (keySize1024 ? 11 : 12);
            byte[] pemModulus = (keySize1024 ? new byte[128] : new byte[256]);
            Array.Copy(keyData, index, pemModulus, 0, pemModulus.Length);

            index += pemModulus.Length;
            index += 2;
            byte[] pemPublicExponent = new byte[3];
            Array.Copy(keyData, index, pemPublicExponent, 0, 3);

            index += 3;
            index += 4;
            if ((int)keyData[index] == 0)
            {
                index++;
            }
            byte[] pemPrivateExponent = (keySize1024 ? new byte[128] : new byte[256]);
            Array.Copy(keyData, index, pemPrivateExponent, 0, pemPrivateExponent.Length);

            index += pemPrivateExponent.Length;
            index += (keySize1024 ? ((int)keyData[index + 1] == 64 ? 2 : 3) : ((int)keyData[index + 2] == 128 ? 3 : 4));
            byte[] pemPrime1 = (keySize1024 ? new byte[64] : new byte[128]);
            Array.Copy(keyData, index, pemPrime1, 0, pemPrime1.Length);

            index += pemPrime1.Length;
            index += (keySize1024 ? ((int)keyData[index + 1] == 64 ? 2 : 3) : ((int)keyData[index + 2] == 128 ? 3 : 4));
            byte[] pemPrime2 = (keySize1024 ? new byte[64] : new byte[128]);
            Array.Copy(keyData, index, pemPrime2, 0, pemPrime2.Length);

            index += pemPrime2.Length;
            index += (keySize1024 ? ((int)keyData[index + 1] == 64 ? 2 : 3) : ((int)keyData[index + 2] == 128 ? 3 : 4));
            byte[] pemExponent1 = (keySize1024 ? new byte[64] : new byte[128]);
            Array.Copy(keyData, index, pemExponent1, 0, pemExponent1.Length);

            index += pemExponent1.Length;
            index += (keySize1024 ? ((int)keyData[index + 1] == 64 ? 2 : 3) : ((int)keyData[index + 2] == 128 ? 3 : 4));
            byte[] pemExponent2 = (keySize1024 ? new byte[64] : new byte[128]);
            Array.Copy(keyData, index, pemExponent2, 0, pemExponent2.Length);

            index += pemExponent2.Length;
            index += (keySize1024 ? ((int)keyData[index + 1] == 64 ? 2 : 3) : ((int)keyData[index + 2] == 128 ? 3 : 4));
            byte[] pemCoefficient = (keySize1024 ? new byte[64] : new byte[128]);
            Array.Copy(keyData, index, pemCoefficient, 0, pemCoefficient.Length);

            RSAParameters para = new RSAParameters();
            para.Modulus = pemModulus;
            para.Exponent = pemPublicExponent;
            para.D = pemPrivateExponent;
            para.P = pemPrime1;
            para.Q = pemPrime2;
            para.DP = pemExponent1;
            para.DQ = pemExponent2;
            para.InverseQ = pemCoefficient;
            return para;
        }
        // <summary>
        /// 将pem格式公钥(1024 or 2048)转换为RSAParameters
        /// </summary>
        /// <param name="pemFileConent">pem公钥内容</param>
        /// <returns>转换得到的RSAParamenters</returns>
        public static RSAParameters ConvertFromPemPublicKey(string pemFileConent)
        {
            if (string.IsNullOrEmpty(pemFileConent))
            {
                throw new ArgumentNullException("pemFileConent", "This arg cann't be empty.");
            }
            pemFileConent = pemFileConent.Replace("-----BEGIN PUBLIC KEY-----", "").Replace("-----END PUBLIC KEY-----", "").Replace("\n", "").Replace("\r", "");
            byte[] keyData = Convert.FromBase64String(pemFileConent);
            bool keySize1024 = (keyData.Length == 162);
            bool keySize2048 = (keyData.Length == 294);
            if (!(keySize1024 || keySize2048))
            {
                throw new ArgumentException("pem file content is incorrect, Only support the key size is 1024 or 2048");
            }
            byte[] pemModulus = (keySize1024 ? new byte[128] : new byte[256]);
            byte[] pemPublicExponent = new byte[3];
            Array.Copy(keyData, (keySize1024 ? 29 : 33), pemModulus, 0, (keySize1024 ? 128 : 256));
            Array.Copy(keyData, (keySize1024 ? 159 : 291), pemPublicExponent, 0, 3);
            RSAParameters para = new RSAParameters();
            para.Modulus = pemModulus;
            para.Exponent = pemPublicExponent;
            return para;
        }
       
    
        //------- Parses binary asn.1 PKCS #8 PrivateKeyInfo; returns RSACryptoServiceProvider ---
        public static RSACryptoServiceProvider DecodePrivateKeyInfo(byte[] pkcs8)
        {
            // encoded OID sequence for  PKCS #1 rsaEncryption szOID_RSA_RSA = "1.2.840.113549.1.1.1"
            // this byte[] includes the sequence byte and terminal encoded null 
            byte[] SeqOID = { 0x30, 0x0D, 0x06, 0x09, 0x2A, 0x86, 0x48, 0x86, 0xF7, 0x0D, 0x01, 0x01, 0x01, 0x05, 0x00 };
            byte[] seq = new byte[15];
            // ---------  Set up stream to read the asn.1 encoded SubjectPublicKeyInfo blob  ------
            MemoryStream mem = new MemoryStream(pkcs8);
            int lenstream = (int)mem.Length;
            BinaryReader binr = new BinaryReader(mem);    //wrap Memory Stream with BinaryReader for easy reading
            byte bt = 0;
            ushort twobytes = 0;

            try
            {

                twobytes = binr.ReadUInt16();
                if (twobytes == 0x8130)	//data read as little endian order (actual data order for Sequence is 30 81)
                    binr.ReadByte();	//advance 1 byte
                else if (twobytes == 0x8230)
                    binr.ReadInt16();	//advance 2 bytes
                else
                    return null;


                bt = binr.ReadByte();
                if (bt != 0x02)
                    return null;

                twobytes = binr.ReadUInt16();

                if (twobytes != 0x0001)
                    return null;

                seq = binr.ReadBytes(15);		//read the Sequence OID
                if (!CompareBytearrays(seq, SeqOID))	//make sure Sequence for OID is correct
                    return null;

                bt = binr.ReadByte();
                if (bt != 0x04)	//expect an Octet string 
                    return null;

                bt = binr.ReadByte();		//read next byte, or next 2 bytes is  0x81 or 0x82; otherwise bt is the byte count
                if (bt == 0x81)
                    binr.ReadByte();
                else
                    if (bt == 0x82)
                        binr.ReadUInt16();
                //------ at this stage, the remaining sequence should be the RSA private key

                byte[] rsaprivkey = binr.ReadBytes((int)(lenstream - mem.Position));
                RSACryptoServiceProvider rsacsp = DecodeRSAPrivateKey(rsaprivkey);
                return rsacsp;
            }

            catch (Exception)
            {
                return null;
            }

            finally { binr.Close(); }

        }
        //------- Parses binary ans.1 RSA private key; returns RSACryptoServiceProvider  ---
        public static RSACryptoServiceProvider DecodeRSAPrivateKey(byte[] privkey)
        {
            byte[] MODULUS, E, D, P, Q, DP, DQ, IQ;

            // ---------  Set up stream to decode the asn.1 encoded RSA private key  ------
            MemoryStream mem = new MemoryStream(privkey);
            BinaryReader binr = new BinaryReader(mem);    //wrap Memory Stream with BinaryReader for easy reading
            byte bt = 0;
            ushort twobytes = 0;
            int elems = 0;
            try
            {
                twobytes = binr.ReadUInt16();
                if (twobytes == 0x8130)	//data read as little endian order (actual data order for Sequence is 30 81)
                    binr.ReadByte();	//advance 1 byte
                else if (twobytes == 0x8230)
                    binr.ReadInt16();	//advance 2 bytes
                else
                    return null;

                twobytes = binr.ReadUInt16();
                if (twobytes != 0x0102)	//version number
                    return null;
                bt = binr.ReadByte();
                if (bt != 0x00)
                    return null;


                //------  all private key components are Integer sequences ----
                elems = GetIntegerSize(binr);
                MODULUS = binr.ReadBytes(elems);

                elems = GetIntegerSize(binr);
                E = binr.ReadBytes(elems);

                elems = GetIntegerSize(binr);
                D = binr.ReadBytes(elems);

                elems = GetIntegerSize(binr);
                P = binr.ReadBytes(elems);

                elems = GetIntegerSize(binr);
                Q = binr.ReadBytes(elems);

                elems = GetIntegerSize(binr);
                DP = binr.ReadBytes(elems);

                elems = GetIntegerSize(binr);
                DQ = binr.ReadBytes(elems);

                elems = GetIntegerSize(binr);
                IQ = binr.ReadBytes(elems);

                Console.WriteLine("showing components ..");


                // ------- create RSACryptoServiceProvider instance and initialize with public key -----
                RSACryptoServiceProvider RSA = new RSACryptoServiceProvider();
                RSAParameters RSAparams = new RSAParameters();
                RSAparams.Modulus = MODULUS;
                RSAparams.Exponent = E;
                RSAparams.D = D;
                RSAparams.P = P;
                RSAparams.Q = Q;
                RSAparams.DP = DP;
                RSAparams.DQ = DQ;
                RSAparams.InverseQ = IQ;
                RSA.ImportParameters(RSAparams);
                return RSA;
            }
            catch (Exception)
            {
                return null;
            }
            finally { binr.Close(); }
        }
        private static int GetIntegerSize(BinaryReader binr)
        {
            byte bt = 0;
            byte lowbyte = 0x00;
            byte highbyte = 0x00;
            int count = 0;
            bt = binr.ReadByte();
            if (bt != 0x02)		//expect integer
                return 0;
            bt = binr.ReadByte();

            if (bt == 0x81)
                count = binr.ReadByte();	// data size in next byte
            else
                if (bt == 0x82)
                {
                    highbyte = binr.ReadByte();	// data size in next 2 bytes
                    lowbyte = binr.ReadByte();
                    byte[] modint = { lowbyte, highbyte, 0x00, 0x00 };
                    count = BitConverter.ToInt32(modint, 0);
                }
                else
                {
                    count = bt;		// we already have the data size
                }



            while (binr.ReadByte() == 0x00)
            {	//remove high order zeros in data
                count -= 1;
            }
            binr.BaseStream.Seek(-1, SeekOrigin.Current);		//last ReadByte wasn't a removed zero, so back up a byte
            return count;
        }
        private static bool CompareBytearrays(byte[] a, byte[] b)
        {
            if (a.Length != b.Length)
                return false;
            int i = 0;
            foreach (byte c in a)
            {
                if (c != b[i])
                    return false;
                i++;
            }
            return true;
        }
        /// <summary>  
        /// 获取文件的MD5码  
        /// </summary>  
        /// <param name="fileName">传入的文件名（含路径及后缀名）</param>  
        /// <returns></returns> 
        public static string GetMD5HashFromFile(string fileName)
        {
            try
            {
                FileStream file = new FileStream(fileName, System.IO.FileMode.Open);
                MD5 md5 = new MD5CryptoServiceProvider();
                byte[] retVal = md5.ComputeHash(file);
                file.Close();
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < retVal.Length; i++)
                {
                    sb.Append(retVal[i].ToString("x2"));
                }
                return sb.ToString();
            }
            catch (Exception ex)
            {
                throw new Exception("GetMD5HashFromFile() fail,error:" + ex.Message);
            }
        }
        /// <summary>  
        /// 置入原始参数sParaTemp
        /// </summary>  
        /// <returns>加密以后的sParaTemp list集合</returns> 
        public static SortedList<string, string> Encryption_sParaTemp(SortedList<string, string> sParaTemp)
        {
            foreach (string i in com.sinapay.sinapay_config.get_need_RSA())
            {
                if (sParaTemp.IndexOfKey(i) != -1)
                {
                    sParaTemp[i] = com.sinapay.weibopayapi.RSA_PEM_Encrypt(sParaTemp[i].ToString().Trim());
                }
            }
            return sParaTemp;
        }
    }
}

