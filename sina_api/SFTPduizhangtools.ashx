<%@ WebHandler Language="C#" Class="getSignMsg" %>
using System;
using System.Web;
using System.Collections.Generic;
using System.Text;
using System.Data;


public class getSignMsg : IHttpHandler
{
    public void ProcessRequest (HttpContext context) 
    {
        context.Response.ContentType = "text/plain";
        StringBuilder sb = new StringBuilder();
        sb.Append("{");
        DateTime currentTime = DateTime.Now;
        //string time = currentTime.ToString("yyyyMMdd");//生产环境中请用这个为当天的对账文件，联调环境中为20150623
        string time = "20180121";
        string TaskType = "jymx-zjtg";
        string lujingstr = AppDomain.CurrentDomain.BaseDirectory;//当前目录
        try { 
        //下载文件
        SFTPHelper sftp = new SFTPHelper();
        sftp.Connect();
        sftp.Download("/upload/busiexport/"+time+"_"+TaskType+".zip", lujingstr + "/sftpduizhang/");//下载到当前目录的/sftpduizhang/文件夹下
        sftp.Close();
        //解压文件
        ZipHelper zipdemo = new ZipHelper();
        zipdemo.UnZip(lujingstr + "/sftpduizhang/" + time + "_" + TaskType + ".zip", lujingstr + "/sftpduizhang/" + time + "_" + TaskType + "", null, true);
        //读取scv文件
        Encoding encodingdf = Encoding.Default;
        CsvStreamReader csv = new CsvStreamReader(lujingstr + "sftpduizhang/" + time + "_" + TaskType + "/" + time + "_" + TaskType + "_80567.csv", encodingdf);
        sb.Append("\"下载sftp上的文件是\":\"/upload/busiexport/" + time + "_" + TaskType + ".zip\",");
        sb.Append("\"解压csv文件并且读取成功，第一行第一列是\":\"" + csv[2, 1].ToString().Trim() + "\"");
        }
        catch(Exception e)
        {
            sb.Append("\"upresult\":\"" + "下载失败，请确认您的IP所处新浪白名单范围内" + "\"");
            System.Diagnostics.Debug.WriteLine(e.ToString());
        }
        sb.Append("}");
        context.Response.Write(sb.ToString());
        }
    //设置线程安全 true 支持并发，false不支持
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
 
}