<%@ WebHandler Language="C#" Class="getSignMsg" %>
using System;
using System.Web;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.IO;
using ICSharpCode.SharpZipLib.Checksums;
using ICSharpCode.SharpZipLib.Zip;
using com.sinapay;

public class getSignMsg : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        StringBuilder sb = new StringBuilder();
        LogClass logs = new LogClass();
        sb.Append("{");
        if (context.Request.Files.Count > 0)
        {//严格按照新浪规则压缩文件
            string strname = DateTime.Now.ToString("yyyyMMddHHmmss");
            string strPath = System.Web.HttpContext.Current.Server.MapPath("~/" + "UPload/" + strname);//需要压缩的路径
            string strzipnames = strPath + ".zip";//压缩包名字
            if (!System.IO.Directory.Exists(strPath))
            {
                System.IO.Directory.CreateDirectory(strPath + "/" + strname);
            }
            for (int i = 0; i < context.Request.Files.Count; i++)
                {
                    string strName = context.Request.Files.AllKeys[i] + ".png";
                    context.Request.Files[i].SaveAs(System.IO.Path.Combine(strPath + "/" + strname, strName));
                }
            clsZip Zc = new clsZip();
            Zc.ZipDir(strPath, strzipnames);
            string digest = com.sinapay.weibopayapi.MD5File(strzipnames).ToLower();//文件摘要;
            try
            {
                 SFTPHelper sftp = new SFTPHelper();
                 sftp.Connect();
                 sftp.Upload(strzipnames, "upload");
                 sftp.Close();
                 sb.Append("\"upresult\":\"" + "success" + "\",");
                 sb.Append("\"fileName\":\"" + strname + ".zip" + "\",");
                 sb.Append("\"digest\":\"" + digest + "\"");
                 logs.WriteLogFile("上传成功，计算出来的文件是：" + strPath + ".zip" + ":" + digest);
             }
            catch(Exception e)
            {   //上传失败
                    sb.Append("\"upresult\":\"" + "上传失败，请确认您的IP所处新浪白名单范围内" + "\"");
                    logs.WriteLogFile(e.ToString());
            }
        }
        else
        {   //创建失败
            sb.Append("\"upresult\":\"" + "没有上传任何图片文件" + "\"");
        }
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