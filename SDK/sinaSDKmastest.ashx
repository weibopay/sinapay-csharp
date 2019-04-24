<%@ WebHandler Language="C#" Class="send" %>
using System;
using System.Web;
using System.Net;
using System.Text;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using com.sinapay;

public class send : IHttpHandler
{
    //测试
    public void ProcessRequest(HttpContext context)
    {
        createB2cOrder();
        //createBatchPay2account();
    }
    	
	public void createB2cOrder()
	{
        SortedList<string, string> risk_info = new SortedList<string, string>();
        risk_info.Add("goods_code", "100101");
        risk_info.Add("goods_name", "商品");
        risk_info.Add("mobile", "00wZtIwJYRZIEhFMUsVfhb9");
        SortedList<string, string> device_info = new SortedList<string, string>();
        device_info.Add("device_id", "76:31:c1:c3:10:dc");
        device_info.Add("device_type", "PC");
        string[,] split_list = new string[3,8] { 
        {"10014542","UID","BASIC","10015543","UID","BASIC","3.00","备注"},
        {"10014543","UID","BASIC","10015544","UID","BASIC","3.00","备注"},
        {"10014544","UID","BASIC","10015545","UID","BASIC","3.00","备注"},
        };
        Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "create_b2c_order");
		sParaTemp.Add("seller_account_type", "BASIC");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("buyer_identity_type", "UID");
		sParaTemp.Add("reported_identity_id", "");
		sParaTemp.Add("settlement_time", "");
		sParaTemp.Add("product_desc", "");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
        sParaTemp.Add("split_list", split_list);
		sParaTemp.Add("return_url", "http://XXX.com/return");
		sParaTemp.Add("risk_info", risk_info);
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("extend_param", "");
		sParaTemp.Add("amount", "10");
		sParaTemp.Add("seller_identity_type", "UID");
		sParaTemp.Add("pay_method", "online_bank^10^SINAPAY,DEBIT,C");
		sParaTemp.Add("notify_url", "http://XXX.com/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("payer_ip", "192.168.1.4");
		sParaTemp.Add("out_trade_no", "collecttrade20190409110849");
        sParaTemp.Add("device_info", device_info);
		sParaTemp.Add("buyer_identity_id", "20181012100627");
		sParaTemp.Add("reported_identity_type", "UID");
		sParaTemp.Add("trade_close_time", "");
		sParaTemp.Add("seller_identity_id", "20181012100705");
        com.sinapay.sinaSDK.mas_url = "https://gate.pay.sina.com.cn/mas/gateway.do";
        SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mas_sdk(sParaTemp);
	}
	
	public void payOrder()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "pay_order");
		sParaTemp.Add("device_id", "");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("pay_method", "online_bank^20^SINAPAY,DEBIT,C");
		sParaTemp.Add("notify_url", "http://XXX.com/Notify");
		sParaTemp.Add("out_pay_no", "paytrade20190409111242");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("payer_ip", "192.168.1.4");
		sParaTemp.Add("request_time", "20190409111242");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("out_trade_no", "withdraw20190319110821");
		sParaTemp.Add("return_url", "http://XXX.com/return");
		sParaTemp.Add("sign_type", "RSA");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mas_sdk(sParaTemp);
	}
	
	public void advanceHostingPay()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "advance_hosting_pay");
		sParaTemp.Add("user_ip", "101.231.34.38");
		sParaTemp.Add("ticket", "324e3bfecb3b4ffb94c9000bf73021ba");
		sParaTemp.Add("validate_code", "025689");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "http://XXX.com/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("request_time", "20190409111330");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("out_advance_no", "advance20190409111330");
		sParaTemp.Add("return_url", "http://XXX.com/return");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("extend_param", "");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mas_sdk(sParaTemp);
		
	}
	
	public void settleB2cOrder()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "settle_b2c_order");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "http://XXX.com/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("request_time", "20190409111725");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("out_trade_no", "collecttrade20190409110849");
		sParaTemp.Add("return_url", "http://XXX.com/return");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("out_request_no", "request20190409111725");
		sParaTemp.Add("extend_param", "");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mas_sdk(sParaTemp);
		
	}
	
	public void closeB2cOrder()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "close_b2c_order");
		sParaTemp.Add("summary", "交易关闭");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "http://XXX.com/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("request_time", "20190409111746");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("out_trade_no", "collecttrade20190409110849");
		sParaTemp.Add("return_url", "http://XXX.com/return");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("out_request_no", "request20190409111746");
		sParaTemp.Add("extend_param", "");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mas_sdk(sParaTemp);
		
	}
	
	public void cancelB2cOrder()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "cancel_b2c_order");
		sParaTemp.Add("summary", "交易撤销");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "http://XXX.com/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("request_time", "20190409111806");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("out_trade_no", "collecttrade20190409110849");
		sParaTemp.Add("return_url", "http://XXX.com/return");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("out_request_no", "request20190409111806");
		sParaTemp.Add("extend_param", "");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mas_sdk(sParaTemp);
		
	}
	
	public void extendSettleTime()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "extend_settle_time");
		sParaTemp.Add("summary", "延长交易结算时间");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "http://XXX.com/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("extend_time", "15d");
		sParaTemp.Add("request_time", "20190409111828");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("out_trade_no", "collecttrade20190409110849");
		sParaTemp.Add("return_url", "http://XXX.com/return");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("out_request_no", "request20190409111828");
		sParaTemp.Add("extend_param", "");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mas_sdk(sParaTemp);
		
	}
	
	public void queryHostingTrade()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "query_hosting_trade");
		sParaTemp.Add("identity_id", "20190409104630");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("end_time", "20190409111906");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("page_no", "");
		sParaTemp.Add("notify_url", "http://XXX.com/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("start_time", "20190409111906");
		sParaTemp.Add("request_time", "20190409111906");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("out_trade_no", "collecttrade20190409110849");
		sParaTemp.Add("return_url", "http://XXX.com/return");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("extend_param", "");
		sParaTemp.Add("page_size", "");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mas_sdk(sParaTemp);
		
	}
	
	public void createHostingRefund()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "create_hosting_refund");
		sParaTemp.Add("summary", "流标退款");
		sParaTemp.Add("user_ip", "101.231.34.38");
		sParaTemp.Add("refund_split_strategy", "");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "http://XXX.com/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("refund_split_list", "");
		sParaTemp.Add("request_time", "20190409111929");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("out_trade_no", "refund20190409111929");
		sParaTemp.Add("return_url", "http://XXX.com/return");
		sParaTemp.Add("refund_amount", "2");
		sParaTemp.Add("orig_outer_trade_no", "collecttrade20190409110849");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("extend_param", "");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mas_sdk(sParaTemp);
		
	}
	
	public void queryHostingRefund()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "query_hosting_refund");
		sParaTemp.Add("identity_id", "20190409104630");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("end_time", "20190409111958");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("page_no", "");
		sParaTemp.Add("notify_url", "http://XXX.com/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("start_time", "20190409111958");
		sParaTemp.Add("request_time", "20190409111958");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("out_trade_no", "refund20190409111929");
		sParaTemp.Add("return_url", "http://XXX.com/return");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("extend_param", "");
		sParaTemp.Add("page_size", "");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mas_sdk(sParaTemp);
		
	}
	
	public void createBatchPay2bank()
	{
        string[,] detail_list = new string[3,13] { 
        {"2019052497600222",com.sinapay.weibopayapi.RSA_PEM_Encrypt("鲁班"),com.sinapay.weibopayapi.RSA_PEM_Encrypt("110105200010107012"),com.sinapay.weibopayapi.RSA_PEM_Encrypt("62218882000604489333"),"中国工商银行","ICBC","浙江省","杭州市","中国农业银行深圳南山支行","30","C","DEBIT","备注"},
        {"2019052497600222",com.sinapay.weibopayapi.RSA_PEM_Encrypt("李白"),com.sinapay.weibopayapi.RSA_PEM_Encrypt("110105200010106394"),com.sinapay.weibopayapi.RSA_PEM_Encrypt("62218882000604489334"),"中国工商银行","ICBC","浙江省","杭州市","中国农业银行深圳南山支行","30","C","DEBIT","备注"},
        {"2019052497600222",com.sinapay.weibopayapi.RSA_PEM_Encrypt("程咬金"),com.sinapay.weibopayapi.RSA_PEM_Encrypt("110105200010108330"),com.sinapay.weibopayapi.RSA_PEM_Encrypt("62218882000604489335"),"中国工商银行","ICBC","浙江省","杭州市","中国农业银行深圳南山支行","30","C","DEBIT","备注"},
        };
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "create_batch_pay2bank");
		sParaTemp.Add("account_type", "");
		sParaTemp.Add("batch_no", "bath20190409112021");
		sParaTemp.Add("_input_charset", "utf-8");
        sParaTemp.Add("detail_list", detail_list);
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "http://XXX.com/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("request_time", "20190409112021");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("return_url", "http://XXX.com/return");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("payto_type", "");
		sParaTemp.Add("extend_param", "");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mas_sdk(sParaTemp);
		
	}
	
	public void createBatchPay2account()
	{
        string[,] detail_list = new string[4, 7] { 
        {"2019052493600222","12345","UID","BASIC","10","还钱",""},
        {"2019052493600223","12346","UID","BASIC","20","还钱",""},
        {"2019052493600224","12347","UID","BASIC","25","还钱",""},
        {"2019052493600225","12348","UID","BASIC","30","还钱",""},
        };
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "create_batch_pay2account");
		sParaTemp.Add("account_type", "");
		sParaTemp.Add("batch_no", "bath20190409112044");
		sParaTemp.Add("_input_charset", "utf-8");
        sParaTemp.Add("detail_list", detail_list);
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "http://XXX.com/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("request_time", "20190409112044");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("return_url", "http://XXX.com/return");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("extend_param", "");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mas_sdk(sParaTemp);
		
	}
	
	public void queryB2cBatchFundoutOrder()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "query_b2c_batch_fundout_order");
		sParaTemp.Add("request_time", "20190409112113");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("return_url", "http://XXX.com/return");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("out_batch_no", "bath20190409112044");
		sParaTemp.Add("notify_url", "http://XXX.com/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("sign_type", "RSA");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mas_sdk(sParaTemp);
		
	}
	
	public void receiptSplit()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
        string[,] split_list = new string[3, 9] { 
        {"10014542","UID","BASIC","10015543","UID","BASIC","3.00","备注","20131105154926"},
        {"10014543","UID","BASIC","10015544","UID","BASIC","3.00","备注","20131105154927"},
        {"10014544","UID","BASIC","10015545","UID","BASIC","3.00","备注","20131105154928"},
        };
		sParaTemp.Add("service", "receipt_split");
		sParaTemp.Add("split_type", "");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "http://XXX.com/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("request_time", "20190409112143");
		sParaTemp.Add("partner_id", "20000916888");
        sParaTemp.Add("split_list", split_list);
		sParaTemp.Add("return_url", "http://XXX.com/return");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("orig_out_trade_no", "refund20190409111929");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mas_sdk(sParaTemp);
		
	}
	
	public void queryReceiptSplit()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "query_receipt_split");
		sParaTemp.Add("identity_id", "20190409104630");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("end_time", "20190409112219");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("page_no", "");
		sParaTemp.Add("notify_url", "http://XXX.com/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("start_time", "20190409112219");
		sParaTemp.Add("request_time", "20190409112219");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("out_split_no", "857dhuurk855");
		sParaTemp.Add("return_url", "http://XXX.com/return");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("page_size", "");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mas_sdk(sParaTemp);
		
	}
	
	public void queryHostingBatchTrade()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "query_hosting_batch_trade");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("out_batch_no", "8558ujufoh85225");
		sParaTemp.Add("page_no", "");
		sParaTemp.Add("notify_url", "http://XXX.com/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("request_time", "20190409112250");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("return_url", "http://XXX.com/return");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("page_size", "");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mas_sdk(sParaTemp);
		
	}
    	public void createHostingDeposit()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "create_hosting_deposit");
		sParaTemp.Add("summary", "某某账户充值");
		sParaTemp.Add("account_type", "SAVING_POT");
		sParaTemp.Add("amount", "10");
		sParaTemp.Add("device_id", "");
		sParaTemp.Add("identity_id", "20190411175426");
		sParaTemp.Add("deposit_close_time", "18m");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("pay_method", "online_bank^10^SINAPAY,DEBIT,C");
		sParaTemp.Add("notify_url", "http://10.65.106.62:6070/sinaPayJavaDemo/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("payer_ip", "114.218.183.139");
		sParaTemp.Add("user_fee", "");
        sParaTemp.Add("request_time", "20190411100222");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("out_trade_no", "order20190412100028");
		sParaTemp.Add("return_url", "http://localhost:6070/sinaPayJavaDemo/index.html");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("extend_param", "");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mas_sdk(sParaTemp);
	}
	
	public void queryHostingDeposit()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "query_hosting_deposit");
		sParaTemp.Add("account_type", "SAVING_POT");
		sParaTemp.Add("identity_id", "20190411175426");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("end_time", "20190412100222");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("page_no", "");
		sParaTemp.Add("notify_url", "http://10.65.106.62:6070/sinaPayJavaDemo/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("start_time", "20190411100222");
        sParaTemp.Add("request_time", "20190411100222");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("out_trade_no", "");
		sParaTemp.Add("return_url", "http://localhost:6070/sinaPayJavaDemo/index.html");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("page_size", "");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mas_sdk(sParaTemp);
	}
	
	public void createHostingWithdraw()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "create_hosting_withdraw");
		sParaTemp.Add("summary", "余额提现");
		sParaTemp.Add("withdraw_mode", "CASHDESK");
		sParaTemp.Add("user_ip", "114.218.183.139");
		sParaTemp.Add("account_type", "SAVING_POT");
		sParaTemp.Add("amount", "5");
		sParaTemp.Add("identity_id", "20190411175426");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "http://10.65.106.62:6070/sinaPayJavaDemo/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("card_id", "");
		sParaTemp.Add("user_fee", "");
        sParaTemp.Add("request_time", "20000916888");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("out_trade_no", "withdraw20190412100308");
		sParaTemp.Add("return_url", "http://localhost:6070/sinaPayJavaDemo/index.html");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("withdraw_close_time", "10m");
		sParaTemp.Add("payto_type", "FAST");
		sParaTemp.Add("extend_param", "customNotify^Y");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mas_sdk(sParaTemp);
}
	
	public void queryHostingWithdraw()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "query_hosting_withdraw");
		sParaTemp.Add("account_type", "SAVING_POT");
		sParaTemp.Add("identity_id", "20190411175426");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("end_time", "20190412100402");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("page_no", "");
		sParaTemp.Add("notify_url", "http://10.65.106.62:6070/sinaPayJavaDemo/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("start_time", "20190411100402");
        sParaTemp.Add("request_time", "20000916888");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("out_trade_no", "");
		sParaTemp.Add("return_url", "http://localhost:6070/sinaPayJavaDemo/index.html");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("page_size", "");
        SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mas_sdk(sParaTemp);
	}
	
	
	public void queryFundYield()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "query_fund_yield");
        sParaTemp.Add("request_time", "20000916888");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("return_url", "http://localhost:8080/java_demo_zhanghu/index.html");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "http://10.65.106.83:8080/java_demo_zhanghu/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("fund_code", "000330");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mas_sdk(sParaTemp);
	}

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}