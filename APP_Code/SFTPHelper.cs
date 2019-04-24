using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Tamir.SharpSsh.jsch;
using System.Collections;
using Tamir.SharpSsh;
using com.sinapay;

   /// <summary>
    /// Summary description for SFTPHelper.
    /// </summary>
    public class SFTPHelper
    {
       
        private SshTransferProtocolBase m_sshCp;
        int Port = 50022;

        public bool Connected
        {
            get
            {
                return m_sshCp.Connected;
            }
        }

        public SFTPHelper()
        {
            //
            //TODO: Check connectionInfo
            //

            m_sshCp = new Sftp(sinapay_config.Sftp_Host,sinapay_config.Sftp_User);
             if(sinapay_config.Sftp_IdentityFile != null) 
            {
                m_sshCp.AddIdentityFile(sinapay_config.Sftp_IdentityFile );
            }
        }
        /// <summary>
        /// 连接sftp
        /// </summary>
        public void Connect()
        {
            if(!m_sshCp.Connected)
            {
                m_sshCp.Connect(Port);
            }
        }
        /// <summary>
        /// 断开连接
        /// </summary>
        public void Close()
        {
            if(m_sshCp.Connected)
            {
                m_sshCp.Close();
            }
        }
        /// <summary>
        /// 文件上传
        /// </summary>
        /// <param name="localPath"></param>
        /// <param name="remotePath"></param>
        /// <returns></returns>
        public bool Upload(string localPath,string remotePath)
        {
            try
            {
                if(!m_sshCp.Connected)
                {
                    m_sshCp.Connect();
                }
                m_sshCp.Put(localPath, remotePath);

                return true;
            }
            catch
            {
                return false;
            }

        }
        /// <summary>
        /// 文件下载
        /// </summary>
        /// <param name="remotePath"></param>
        /// <param name="localPath"></param>
        /// <returns></returns>
        public bool Download(string remotePath,string localPath)
        {
            try
            {
                if(!m_sshCp.Connected)
                {
                    m_sshCp.Connect();
                }

                m_sshCp.Get(remotePath,localPath);

                return true;
            }
            catch
            {
                return false;
            }
        }
}