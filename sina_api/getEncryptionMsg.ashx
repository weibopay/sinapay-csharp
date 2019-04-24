<%@ WebHandler Language="C#" Class="getSignMsg" %>
using System;
using System.Web;
using System.Collections.Generic;
using System.Text;
using System.Data;

public class getSignMsg : IHttpHandler
{
    public void ProcessRequest (HttpContext context) {
       context.Response.ContentType = "text/plain";
       //此处为对文档要求的参数进行rsa加密范例，注意：必须先加密以后，再调用签名方法。
       StringBuilder sb = new StringBuilder();
       sb.Append("{");
       for (int i = 0; i < context.Request.Form.Count; i++)
       {
           sb.Append("\"" + context.Request.Form.Keys[i].ToString() + "\":\"" + com.sinapay.weibopayapi.RSA_PEM_Encrypt(context.Request.Form[i].ToString().Trim()) + "\",");
       } 
       if (context.Request.Form.Count == 0) { 
           sb.Append("\"msg\":\"" + "没有需要加密的参数" + "\",");
       } 
       sb.Remove(sb.Length - 1, 1);
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