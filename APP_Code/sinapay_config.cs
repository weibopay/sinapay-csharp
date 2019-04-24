using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;


namespace com.sinapay
{
    /// <summary>
    /// sinapay demo参数配置
    /// </summary>
    public class sinapay_config
    {
        #region 字段
        private static string partner_id;              //商户号  上线前请修改为正式环境资源

        public static string Partner_id
        {
            get { return sinapay_config.partner_id; }
            set { sinapay_config.partner_id = value; }
        }
        private static string public_key;              //加密公钥

        public static string Public_key
        {
            get { return sinapay_config.public_key; }
            set { sinapay_config.public_key = value; }
        }
        private static string sign_public_key;              //rsa签名验证公钥

        public static string Sign_public_key
        {
            get { return sinapay_config.sign_public_key; }
            set { sinapay_config.sign_public_key = value; }
        }
        private static string sign_private_key;              //rsa签名私钥

        public static string Sign_private_key
        {
            get { return sinapay_config.sign_private_key; }
            set { sinapay_config.sign_private_key = value; }
        }
        private static string md5_key;              //MD5签名秘钥

        public static string Md5_key
        {
            get { return sinapay_config.md5_key; }
            set { sinapay_config.md5_key = value; }
        }
        private static string version;//接口版本呢

        public static string Version
        {
            get { return sinapay_config.version; }
            set { sinapay_config.version = value; }
        }
        private static string _input_charset;    //字符集

        public static string Input_charset
        {
            get { return sinapay_config._input_charset; }
            set { sinapay_config._input_charset = value; }
        }
        private static string wpay_url;           //提交地址，交易网关地址

        public static string Wpay_url
        {
            get { return sinapay_config.wpay_url; }
            set { sinapay_config.wpay_url = value; }
        }
        private static string notify_url;        //回调地址

        public static string Notify_url
        {
            get { return sinapay_config.notify_url; }
            set { sinapay_config.notify_url = value; }
        }
        private static string return_url;  //支付完成返回地址

        public static string Return_url
        {
            get { return sinapay_config.return_url; }
            set { sinapay_config.return_url = value; }
        }
        private static string private_key;

        public static string Private_key
        {
            get { return sinapay_config.private_key; }
            set { sinapay_config.private_key = value; }
        }
        public static string Sftp_Host { get; set; }
        public static string Sftp_User { get; set; }
        public static string Sftp_IdentityFile { get; set; }
        #endregion
        /// <summary>
        /// 接口部分参数配置文件商户上线，需要将参数切换为生产环境参数
        /// </summary>
        static sinapay_config()
        {
            string host = HttpContext.Current.Request.ServerVariables.Get("Http_Host").ToString();
            version = "1.0";//接口版本
            partner_id = ""; // 商户号
            _input_charset = "utf-8"; // 字符集编码
            notify_url = "http://" + host + "/sina_api/notify.aspx";//异步回调地址
            return_url = "http://" + host + "/sina_api/return.aspx";//返回地址
            public_key = AppDomain.CurrentDomain.BaseDirectory + "key/rsa_public.pem";//此为联调环境加密公钥，生产环境KEY由新浪提供
            sign_public_key = AppDomain.CurrentDomain.BaseDirectory + "key/rsa_sign_public.pem";//此为联调环境验证签名公钥，生产环境KEY由新浪提供
            sign_private_key = AppDomain.CurrentDomain.BaseDirectory + "key/rsa_sign_private.pem";//此为联调环境计算签名私钥  生产环境KEY由商户自行生成
            //sftp配置参数
            Sftp_Host = "222.73.39.37";//联调环境SFTPip地址
            Sftp_User = "";//sftp 用户名
            Sftp_IdentityFile = AppDomain.CurrentDomain.BaseDirectory + "key/id_rsa";//登陆sftp私钥
        }
        public static string[,] get_trade_Interface_service()
        {
            string[,] trade_Interface_service =      //交易类网关服务
                 {  
                        {"create_b2c_order","交易创建"},
                        {"pay_b2c_order","交易付款"},
                        {"advance_hosting_pay","付款推进（快捷支付验证码推进）"},
                        {"settle_b2c_order","交易结算"},
                        {"close_b2c_order","交易关闭"},
                        {"cancel_b2c_order","交易撤销"},
                        {"extend_settle_time","延长交易结算时间"},
                        {"query_pay_result","支付结果查询"},
                        {"query_hosting_trade","交易查询"},
                        {"create_hosting_refund","退款"},                
                        {"query_hosting_refund","退款查询"},
                        {"create_batch_pay2bank","批量付款到银行卡"},
                        {"query_b2c_batch_fundout_order","出款批次查询"},
                        {"create_hosting_deposit","充值"},
                        {"query_hosting_deposit","充值查询"},
                        {"create_hosting_withdraw","提现"},
                        {"query_hosting_withdraw","提现查询"},
                        {"query_fund_yield","存钱罐基金收益率查询"},
                        {"create_batch_pay2account","批量付款到账户"},
                        {"pay_order","再次支付"},
                        {"receipt_split","分账"},
                        {"query_receipt_split","分账查询"},
                        {"query_hosting_batch_trade","交易批次查询"},
                 };
            return trade_Interface_service;
        }
        public static string[,] get_member_Interface_service()
        {
            string[,] member_Interface_service = new string[,]
                {           //会员类网关服务
                        {"create_activate_member","创建激活会员"},
                        {"set_real_name","设置实名信息"},
                        {"binding_bank_card","绑定银行卡"},
                        {"binding_bank_card_advance","绑定银行卡推进"},
                        {"unbinding_bank_card","解绑银行卡"},
                        {"unbinding_bank_card_advance","解绑银行卡推进"},
                        {"query_bank_card","查询银行卡"},
                        {"change_bank_mobile","修改银行预留手机"},
                        {"change_bank_mobile_advance","修改银行预留手机推进"},
                        {"audit_member_infos","请求审核企业会员资质"},
                        {"smt_fund_agent_buy","经办人信息"},
                        {"query_fund_agent_buy","查询经办人信息"},
                        {"query_member_infos","查询企业会员信息"},
                        {"query_audit_result","查询企业会员审核结果"},
                        {"set_pay_password","设置支付密码重定向"},
                        {"modify_pay_password","修改支付密码重定向"},
                        {"find_pay_password","找回支付密码重定向"},
                        {"query_is_set_pay_password","查询是否设置支付密码"},
                        {"query_balance","查询余额/基金份额"},
                        {"query_account_details","查询收支明细"},
                        {"balance_freeze","冻结余额"},
                        {"balance_unfreeze","解冻余额"},
                        {"query_ctrl_result","查询冻结解冻结果"},
				        {"modify_verify_mobile","修改认证手机"},
				        {"find_verify_mobile","找回认证手机"},
                        {"handle_withhold_authority","委托扣款重定向"},
                        {"modify_withhold_authority","修改委托扣款重定向"},
                        {"relieve_withhold_authority","解除委托扣款重定向"},
                        {"query_withhold_authority","查看用户是否委托扣款"},
                        {"query_merchant_config","查询商户配置"},
                        {"set_merchant_config","修改商户配置"},
                        {"merchant_report","商户信息报备"},
                        {"query_trade_related_no","查询新浪待结算账户余额"},
                        {"smerchant_url_get","跳转新浪支付子商户平台重定向"},
                };
            return member_Interface_service;
        }
        
        /// <summary>
        /// 传入参数服务名称，
        /// 返回对应的请求地址
        /// </summary>
        public static string get_url(string service_name)
        {
            JavaScriptSerializer js = new JavaScriptSerializer();
            if (js.ConvertToType<List<string>>(sinapay_config.get_trade_Interface_service()).Contains(service_name))
            {
                wpay_url = "https://testgate.pay.sina.com.cn/mas/gateway.do";// 网管地址 此处为测试交易类接口地址，请根据实际情况填写
            }
            else if (js.ConvertToType<List<string>>(sinapay_config.get_member_Interface_service()).Contains(service_name))
            {
                wpay_url = "https://testgate.pay.sina.com.cn/mgs/gateway.do";// 网管地址 此处为测试会员类接口地址，请根据实际情况填写
            }
            return wpay_url;
        }
        /// <summary>
        /// 返回需要加密的参数名的集合
        /// </summary>
        public static string[] get_need_RSA()
        {
            string[] array = {"real_name", "cert_no", "verify_entity","bank_account_no","account_name",
    			"phone_no","validity_period","verification_value","telephone","email","organization_no",
    			"legal_person","legal_person_phone","agent_name","license_no","agent_mobile"};
            return array;
        }

    }
}