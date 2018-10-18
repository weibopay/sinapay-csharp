<%@ WebHandler Language="C#" Class="getSignMsg" Debug="True"%>
using System;
using System.Web;
using System.Collections.Generic;
using System.Text;
using System.Data;
using com.sinapay;

public class getSignMsg : IHttpHandler
{
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        //取得的外部过来的参数串，此处外部的数据为context.Request.Form表单，并且拼接成一个SortedList做为范例，商户可以嵌入程序的时候放置SortedList即可
        SortedList<string, string> sParaTemp = new SortedList<string, string>();
        LogClass logs = new LogClass();
        for (int i = 0; i < context.Request.Form.Count; i++)
        {
            if (context.Request.Form[i].ToString() != null)
            {
                sParaTemp.Add(context.Request.Form.Keys[i].ToString(), context.Request.Form[i].ToString());
            }
        }
        string SignMsg = com.sinapay.weibopayapi.GetSignMsg(logs,sParaTemp, sParaTemp["sign_type"]);//加签
       StringBuilder sb = new StringBuilder();
       sb.Append("{");
       sb.Append("\"sign\":\"" + SignMsg + "\"");
       sb.Append("}");
       context.Response.Write(sb.ToString());
        }
 
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
 
}