using System;
using System.Web;
using System.Net;
using System.Text;
using System.Collections.Generic;
using System.IO;
using System.Collections;
using com.sinapay;


namespace com.sinapay
{
    public class sinaSDK{
        public sinaSDK() {}
        public static string mas_url = "https://testgate.pay.sina.com.cn/mas/gateway.do";//联调地址，商户切换生产以后请换为文档要求的地址;
        public static string mgs_url = "https://testgate.pay.sina.com.cn/mgs/gateway.do";//联调地址，商户切换生产以后请换为文档要求的地址;
        //交易类的接口请使用这个方法
        public static SortedList<string, string> mas_sdk(Dictionary<string, Object> sParaTemp)
        {
            SortedList<string, string> mas_result = send_tool(sParaTemp, mas_url);
            return mas_result;
        }
        //会员类的接口请使用这个方法
        public static SortedList<string, string> mgs_sdk(Dictionary<string, Object> sParaTemp)
        {
            SortedList<string, string> mgs_result = send_tool(sParaTemp, mgs_url);
            return mgs_result;
        }
        public static SortedList<string, string> send_tool(Dictionary<string, Object> ParaTemp, String send_url)
        {
            LogClass logs = new LogClass();
            SortedList<string, string> pay_result = new SortedList<string, string>();
            SortedList<string, string> sParaTemp = new SortedList<string, string>();
            logs.WriteLogFile("开始进入SDK 传入的对象是：" + new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(ParaTemp));
            try
            { 
            foreach (KeyValuePair<string, Object> k in ParaTemp)
            {
                if ((k.Key == "risk_info") || (k.Key == "device_info"))
                {
                    sParaTemp.Add(k.Key, new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(k.Value));
                }
                else if (((ParaTemp["service"] == "create_batch_pay2bank") && (k.Key == "detail_list")) || (k.Key == "split_list"))
                {
                    sParaTemp.Add(k.Key, "");
                    string[,] splittemp = (string[,])(k.Value);
                    for (int i = 0; i < splittemp.GetLength(0); i++)
                    {
                        for (int j = 0; j < splittemp.GetLength(1); j++)
                        {
                             sParaTemp[k.Key] = (j == 0)  ?
                                sParaTemp[k.Key] + splittemp[i, j] :
                                sParaTemp[k.Key] + "^" + splittemp[i, j];
                        }
                        if (i < splittemp.GetLength(0) - 1) { sParaTemp[k.Key] = sParaTemp[k.Key] + "|"; }
                    }
                }
                else if ((ParaTemp["service"] == "create_batch_pay2account") && (k.Key == "detail_list"))
                {
                    sParaTemp.Add(k.Key, "");
                    string[,] splittemp = (string[,])(k.Value);
                    for (int i = 0; i < splittemp.GetLength(0); i++)
                    {
                        for (int j = 0; j < splittemp.GetLength(1); j++)
                        {
                            sParaTemp[k.Key] = (j == 0) ?
                                sParaTemp[k.Key] + splittemp[i, j] : 
                                sParaTemp[k.Key] + "~" + splittemp[i, j];
                        }
                        if (i < splittemp.GetLength(0) - 1) { sParaTemp[k.Key] = sParaTemp[k.Key] + "$"; }
                    }
                }
                else {
                    sParaTemp.Add(k.Key, k.Value.ToString());
                }
            }
            sParaTemp = weibopayapi.Encryption_sParaTemp(sParaTemp);
            string SignMsg = sinapay.weibopayapi.GetSignMsg(logs, sParaTemp, sParaTemp["sign_type"]);//加签
            sParaTemp.Add("sign", SignMsg);
            //排序
            string postDataStr = com.sinapay.weibopayapi.send_url(sParaTemp);
            //发送到新浪
            string result = HttpPost(send_url, postDataStr, logs);
            string jsonresult = HttpUtility.UrlDecode(result, Encoding.GetEncoding(sParaTemp["_input_charset"].ToString()));
            logs.WriteLogFile("网关响应的数据是" + jsonresult);
            var jsonData2 = new System.Web.Script.Serialization.JavaScriptSerializer();
            pay_result = jsonData2.Deserialize<SortedList<string, string>>(jsonresult);
            //验证新浪响应的签名是否正确    
            if (com.sinapay.weibopayapi.Check_SignMsg(pay_result, pay_result["sign_type"].ToString().Trim(), pay_result["sign"].ToString().Trim(), pay_result["_input_charset"], logs))
            {
                logs.WriteLogFile("验证同步响应签名成功。可信任的数据，新浪响应报文是：" + new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(pay_result));
                return pay_result;
            }
            else
            {
                //签名验证错误，正常情况下不会出现签名验证错误，
                logs.WriteLogFile("验证同步响应签名失败。不可信任数据或者KEY使用不正确。报文是：" + new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(pay_result));
                pay_result.Add("SDK_Check_Sign_error", "响应报文验签失败，请检查KEY或者报文");
                return pay_result;
            }
            }
            catch (Exception e) {
                logs.WriteLogFile("捕获异常"+e.ToString());
                pay_result.Add("SDK_Exception", "捕获异常" + e.ToString());
                return pay_result;
            }
        }
        public static string HttpPost(string Url, string postDataStr, LogClass logs)
        {
            logs.WriteLogFile("请求新浪网关地址是" + Url + "请求新浪的完整报文是" + postDataStr);
            byte[] postData = Encoding.UTF8.GetBytes(postDataStr);
            WebClient webClient = new WebClient();
            webClient.Headers.Add("Content-Type", "application/x-www-form-urlencoded");//采取POST方式必须加的header，如果改为GET方式的话就去掉这句话即可  
            byte[] responseData = webClient.UploadData(Url, "POST", postData);//得到返回字符流  
            string srcString = Encoding.UTF8.GetString(responseData);//解码  
            return srcString;
        }
    }
}

