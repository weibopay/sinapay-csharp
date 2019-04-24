<%@ WebHandler Language="C#" Class="send" %>
using System;
using System.Web;
using System.Net;
using System.Text;
using System.Collections.Generic;
using System.IO;
using com.sinapay;

public class send : IHttpHandler
{
    //数据发送
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        // 取得的外部过来的参数串，此处外部的数据为context.Request.Form表单，并且拼接成一个SortedList做为范例，商户可以嵌入程序的时候放置SortedList即可
        // 注意，Trim()剔空首尾空格
        SortedList<string, string> sParaTemp = new SortedList<string, string>();
        //初始化日志类
        LogClass logs = new LogClass();
        for (int i = 0; i < context.Request.Form.Count; i++)
        {
            if (context.Request.Form[i] != null && context.Request.Form[i] != "")
            {
                sParaTemp.Add(context.Request.Form.Keys[i].ToString(), context.Request.Form[i].ToString().Trim());
            }
        }
        try
        {
            //接受到外部来的参数以后，判断是有有需要加密的数组，若有就先加密
            sParaTemp = com.sinapay.weibopayapi.Encryption_sParaTemp(sParaTemp);
            //计算签名，在将签名追加sParaTemp数组中
            string SignMsg = com.sinapay.weibopayapi.GetSignMsg(logs, sParaTemp, sParaTemp["sign_type"]);//加签
            sParaTemp.Add("sign", SignMsg);
            //排序
            string postDataStr = com.sinapay.weibopayapi.send_url(sParaTemp);
            //发送到新浪
            string result = HttpPost(com.sinapay.sinapay_config.get_url(sParaTemp["service"]), postDataStr, logs);
            string jsonresult = HttpUtility.UrlDecode(result, Encoding.GetEncoding(sParaTemp["_input_charset"].ToString()));
            var jsonData2 = new System.Web.Script.Serialization.JavaScriptSerializer();
            try
            {
                //尝试解析是否json报文，否则直接前端输出新浪响应的form表单
                SortedList<string, string> pay_result = jsonData2.Deserialize<SortedList<string, string>>(jsonresult);
                //验证新浪响应的签名是否正确    
                if (com.sinapay.weibopayapi.Check_SignMsg(pay_result, pay_result["sign_type"].ToString().Trim(), pay_result["sign"].ToString().Trim(), pay_result["_input_charset"], logs))
                {
                    context.Response.Write(jsonresult);
                    logs.WriteLogFile("验证同步响应签名成功。可信任的数据，新浪响应报文是：" + new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(pay_result));
                }
                else
                {
                    //签名验证错误，正常情况下不会出现签名验证错误，
                    context.Response.Write("{\"msg\":\"" + "SIGN ERROR!" + "\"}");
                    logs.WriteLogFile("验证同步响应签名失败。不可信任数据或者KEY使用不正确。报文是：" + new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(pay_result));
                }
            }
            catch
            {   //不是json则前端输出新浪响应的【自动提交表单】
                logs.WriteLogFile("新浪响应的自动提交表单是：" + jsonresult);
                context.Response.Write(jsonresult);
            }
        }
        catch (Exception e)
        {
            context.Response.Write("{\"msg\":\"" + "来源异常" + "\"}");
            logs.WriteLogFile("系统异常 Exception e 是：" + e.ToString());
        }
        finally {
            logs.WriteLogFile("done",true);
        }
    }
    private string HttpPost(string Url, string postDataStr,LogClass logs)
    {
        logs.WriteLogFile("请求新浪网关地址是" + Url + "请求新浪的完整报文是" + postDataStr);
        byte[] postData = Encoding.UTF8.GetBytes(postDataStr);
        WebClient webClient = new WebClient();
        webClient.Headers.Add("Content-Type", "application/x-www-form-urlencoded");//采取POST方式必须加的header，如果改为GET方式的话就去掉这句话即可  
        byte[] responseData = webClient.UploadData(Url, "POST", postData);//得到返回字符流  
        string srcString = Encoding.UTF8.GetString(responseData);//解码  
        return srcString;
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}