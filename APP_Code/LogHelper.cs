using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace com.sinapay
{
    public class LogClass
    {
        public string lognumber = "[" + Convert.ToInt64((DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, 0)).TotalSeconds).ToString() + "]:";
        /**/
        /// <summary>
        /// 写入日志文件
        /// </summary>
        /// <param name="input"></param>
        /// <param name="LOGending"></param>
        public void WriteLogFile(string input, bool LOGending = false)
        {
            /**/
            ///指定日志文件的目录
            string fname = AppDomain.CurrentDomain.BaseDirectory + "logs\\" + DateTime.Now.ToString("yyyy-MM-dd") + "-sina_LogFile.txt";//当前目录下的logs
            /**/
            ///定义文件信息对象

            FileInfo finfo = new FileInfo(fname);

            if (!finfo.Exists)
            {
                FileStream fs;
                fs = File.Create(fname);
                fs.Close();
                finfo = new FileInfo(fname);
            }
            byte[] outputByte = System.Text.Encoding.UTF8.GetBytes(DateTime.Now.ToLongDateString() + DateTime.Now.ToLongTimeString() + lognumber + input + "\n\r");
            using (FileStream w = new FileStream(fname, FileMode.Open, FileAccess.Write, FileShare.ReadWrite))
            {

                w.Seek(0, SeekOrigin.End);
                w.Write(outputByte, 0, outputByte.Length);

                if (LOGending == true)
                {
                    byte[] endByte = System.Text.Encoding.UTF8.GetBytes("------------------------------------\n\r");
                    w.Write(endByte, 0, endByte.Length);
                }
                /**/
                ///清空缓冲区内容，并把缓冲区内容写入基础流
                w.Flush();

                /**/
                ///关闭写数据流
                w.Close();
            }

        }
    }
}