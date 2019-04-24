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
    //数据发送
    public void ProcessRequest(HttpContext context)
    {
        queryBankCard();
    }
    public void createMember()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "create_activate_member");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("sign", "");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("sign_version", "1.0");
		sParaTemp.Add("encrypt_version", "1.0");
		sParaTemp.Add("notify_url", "");
		sParaTemp.Add("return_url", "");
		sParaTemp.Add("memo", "创建会员");
		sParaTemp.Add("risk_info", "");
		sParaTemp.Add("device_info", "");
		sParaTemp.Add("identity_id", "655545");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("member_type", "1");
		sParaTemp.Add("client_ip", "127.0.0.1");
		sParaTemp.Add("extend_param", "");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
	}

	
	public void setRealName()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "set_real_name");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("sign", "");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("sign_version", "1.0");
		sParaTemp.Add("encrypt_version", "1.0");
		sParaTemp.Add("notify_url", "");
		sParaTemp.Add("return_url", "");
		sParaTemp.Add("memo", "设置实名信息");
		sParaTemp.Add("risk_info", "");
		sParaTemp.Add("device_info", "");
		sParaTemp.Add("identity_id", "1555051737809");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("real_name", "郭嘉慕");
		sParaTemp.Add("cert_type", "IC");
		sParaTemp.Add("cert_no", "140428200105314950");
		sParaTemp.Add("need_confirm", "Y");
		sParaTemp.Add("client_ip", "127.0.0.1");
		sParaTemp.Add("extend_param", "UID");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	
	
	public void setPayPassword()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "set_pay_password");
		sParaTemp.Add("identity_id", "1555051737809");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("withhold_param", "withhold_auth_type^ALL,ACCOUNT|is_check^Y");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("return_url", "http://www.xxx.com/pay_password.html");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("sign_type", "RSA");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	public void modifyPayPassword()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "modify_pay_password");
		sParaTemp.Add("identity_id", "1555051737809");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("withhold_param", "");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("return_url", "http://www.xxx.com/pay_password.html");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("sign_type", "RSA");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	public void findPayPassword()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "find_pay_password");
		sParaTemp.Add("identity_id", "1555051737809");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("withhold_param", "");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("return_url", "http://www.xxx.com/pay_password.html");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("sign_type", "RSA");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	public void queryIsSetPayPassword()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "query_is_set_pay_password");
		sParaTemp.Add("identity_id", "1555051737809");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("withhold_param", "");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("return_url", "http://www.xxx.com/pay_password.html");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("sign_type", "RSA");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	public void bindingBankCard()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "binding_bank_card");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("sign", "");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("sign_version", "1.0");
		sParaTemp.Add("encrypt_version", "1.0");
		sParaTemp.Add("notify_url", "");
		sParaTemp.Add("return_url", "");
		sParaTemp.Add("memo", "绑定银行卡");
		sParaTemp.Add("risk_info", "");
		sParaTemp.Add("device_info", "");
		sParaTemp.Add("identity_id", "1555051737809");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("request_no", "12345646");
		sParaTemp.Add("bank_code", "ICBC");
		sParaTemp.Add("bank_account_no", "6212264100011335373");
		sParaTemp.Add("account_name", "");
		sParaTemp.Add("card_type", "DEBIT");
		sParaTemp.Add("card_attribute", "C");
		sParaTemp.Add("cert_type", "IC");
		sParaTemp.Add("cert_no", "");
		sParaTemp.Add("phone_no", "18796261167");
		sParaTemp.Add("validity_period", "");
		sParaTemp.Add("verification_value", "");
		sParaTemp.Add("province", "上海市");
		sParaTemp.Add("city", "上海市");
		sParaTemp.Add("bank_branch", "");
		sParaTemp.Add("verify_mode", "SIGN");
		sParaTemp.Add("client_ip", "127.0.0.1");
		sParaTemp.Add("extend_param", "");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
	}
	
	public void bindingBankCardAdvance()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "binding_bank_card_advance");
		sParaTemp.Add("ticket", "0413af017b3143c597951d1cddcd5ded");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("valid_code", "629545");
		sParaTemp.Add("return_url", "http://www.xxx.com/binding_bank_card_advance.html");
		sParaTemp.Add("client_ip", "101.231.34.38");
		sParaTemp.Add("sign_type", "RSA");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	public void queryBankCard()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "query_bank_card");
		sParaTemp.Add("identity_id", "1555051737809");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("card_id", "");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("return_url", "http://www.xxx.com/query_bank_card.html");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("sign_type", "RSA");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	
	public void unbindingBankCard()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "unbinding_bank_card");
		sParaTemp.Add("identity_id", "1555051737809");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("card_id", "398603");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("advance_flag", "Y");
		sParaTemp.Add("return_url", "http://www.xxx.com/unbinding_bank_card.html");
		sParaTemp.Add("client_ip", "101.231.34.38");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("sign_type", "RSA");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	public void unbindingBankCardAdvance()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "unbinding_bank_card_advance");
		sParaTemp.Add("ticket", "5678a662444c44969d282abbf7045b52");
		sParaTemp.Add("identity_id", "1555051737809");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("valid_code", "889534");
		sParaTemp.Add("return_url", "http://www.xxx.com/unbinding_bank_card_advance.html");
		sParaTemp.Add("client_ip", "101.231.34.38");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("sign_type", "RSA");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	
	public void queryBalance()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "query_balance");
		sParaTemp.Add("account_type", "SAVING_POT");
		sParaTemp.Add("identity_id", "1555051737809");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("return_url", "http://www.xxx.com/query_balance.html");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("sign_type", "RSA");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	public void queryAccountDetails()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "query_account_details");
		sParaTemp.Add("account_type", "SAVING_POT");
		sParaTemp.Add("identity_id", "1555051737809");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("end_time", "20190412151846");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("page_no", "1");
		sParaTemp.Add("notify_url", "");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("start_time", "20190411151846");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("return_url", "http://www.xxx.com/query_account_details.html");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("extend_param", "");
		sParaTemp.Add("page_size", "5");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	public void balanceFreeze()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "balance_freeze");
		sParaTemp.Add("summary", "非法占用");
		sParaTemp.Add("account_type", "SAVING_POT");
		sParaTemp.Add("amount", "2");
		sParaTemp.Add("identity_id", "1555051737809");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("return_url", "http://www.xxx.com/balance_freeze.html");
		sParaTemp.Add("out_freeze_no", "freeze20190409103634");
		sParaTemp.Add("client_ip", "101.231.34.38");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("sign_type", "RSA");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	public void balanceUnfreeze()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "balance_unfreeze");
		sParaTemp.Add("out_unfreeze_no", "unfreeze20190409103817");
		sParaTemp.Add("summary", "事件已处理");
		sParaTemp.Add("amount", "2");
		sParaTemp.Add("identity_id", "1555051737809");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("return_url", "http://www.xxx.com/balance_unfreeze.html");
		sParaTemp.Add("out_freeze_no", "freeze20190409103634");
		sParaTemp.Add("client_ip", "101.231.34.38");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("sign_type", "RSA");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	public void queryCtrlResult()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "query_ctrl_result");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("out_ctrl_no", "freeze20190409103634");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("return_url", "http://www.xxx.com/query_ctrl_result.html");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("sign_type", "RSA");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	public void queryMemberInfos()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "query_member_infos");
		sParaTemp.Add("identity_id", "20190411175426");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("is_mask", "N");
		sParaTemp.Add("return_url", "http://www.xxx.com/query_member_infos.html");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("sign_type", "RSA");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	
	public void auditMemberInfos()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "audit_member_infos");
		sParaTemp.Add("member_type", "2");
		sParaTemp.Add("bank_branch", "中国工商银行深圳南山支行");
		sParaTemp.Add("cert_type", "IC");
		sParaTemp.Add("fileName", "20190409104807.zip");
		sParaTemp.Add("license_address", "上海");
		sParaTemp.Add("city", "上海市");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("cert_effect_date", "20151002");
		sParaTemp.Add("cert_invalid_date", "forever");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("card_attribute", "B");
		sParaTemp.Add("legal_person_phone", "18956236585");
		sParaTemp.Add("license_no", "20000000000002");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("province", "上海市");
		sParaTemp.Add("digest", "29880fa0c06ac9df31059d8e84d252a4");
		sParaTemp.Add("return_url", "http://www.xxx.com/index.html");
		sParaTemp.Add("client_ip", "101.231.34.38");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("organization_no", "200010000009");
		sParaTemp.Add("extend_param", "");
		sParaTemp.Add("email", "ms@weibopay.com");
		sParaTemp.Add("summary", "企业简介");
		sParaTemp.Add("bank_code", "ICBC");
		sParaTemp.Add("website", "sssss");
		sParaTemp.Add("legal_person", "李某某");
		sParaTemp.Add("address", "测试公司的企业地址");
		sParaTemp.Add("cert_no", "140428200105314950");
		sParaTemp.Add("identity_id", "20190412152732");
		sParaTemp.Add("digestType", "MD5");
		sParaTemp.Add("bank_account_no", "6212264100011335373");
		sParaTemp.Add("license_expire_date", "20201002");
		sParaTemp.Add("telephone", "4009218887");
		sParaTemp.Add("notify_url", "http://www.xxx.com/Notify");
		sParaTemp.Add("card_type", "DEBIT");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("audit_order_no", "audit_member_20190409104642");
		sParaTemp.Add("business_scope", "软件开发，软件测试，金融");
		sParaTemp.Add("company_name", "测试公司的全称");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	public void queryAuditResult()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "query_audit_result");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("identity_id", "20190411175426");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("return_url", "http://www.xxx.com/query_audit_result.html");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("sign_type", "RSA");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	public void changeBankMobile()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "change_bank_mobile");
		sParaTemp.Add("phone_no", "18796265852");
		sParaTemp.Add("identity_id", "1555051737809");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("request_no", "bil_bancart20190409104856");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "http://www.xxx.com/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("card_id", "152369");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("return_url", "http://www.xxx.com/index.html");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("sign_type", "RSA");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	public void changeBankMobileAdvance()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "change_bank_mobile_advance");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("valid_code", "026302");
		sParaTemp.Add("ticket", "e1b0c41da7954fac8aea8b9ab912b091");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("return_url", "http://www.xxx.com/index.html");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "http://www.xxx.com/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("sign_type", "RSA");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	public void smtFundAgentBuy()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "smt_fund_agent_buy");
		sParaTemp.Add("agent_name", "夏黎珊");
		sParaTemp.Add("identity_id", "20190411175426");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("agent_mobile", "15695263254");
		sParaTemp.Add("notify_url", "http://www.xxx.com/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("license_type_code", "ID");
		sParaTemp.Add("license_no", "330100199910163443");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("return_url", "http://www.xxx.com/index.html");
		sParaTemp.Add("client_ip", "101.231.34.38");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("email", "");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	public void queryFundAgentBuy()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "query_fund_agent_buy");
		sParaTemp.Add("identity_id", "655545");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "http://www.xxx.com/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("return_url", "http://www.xxx.com/index.html");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("extend_param", "");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	public void modifyVerifyMobile()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "modify_verify_mobile");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("identity_id", "20190409104630");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("return_url", "http://www.xxx.com/index.html");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "http://www.xxx.com/Notify");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("sign_type", "RSA");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	public void findVerifyMobile()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "find_verify_mobile");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("identity_id", "20190409104630");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("return_url", "http://www.xxx.com/index.html");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "http://www.xxx.com/Notify");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("sign_type", "RSA");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	public void handleWithholdAuthority()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "handle_withhold_authority");
		sParaTemp.Add("identity_id", "20190409104630");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("auth_type_whitelist", "ALL,ACCOUNT");
		sParaTemp.Add("notify_url", "http://www.xxx.com/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("quota", "2000");
		sParaTemp.Add("return_url", "http://www.xxx.com/index.html");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("extend_param", "");
		sParaTemp.Add("day_quota", "4000");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	public void modifyWithholdAuthority()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "modify_withhold_authority");
		sParaTemp.Add("identity_id", "20190409104630");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "http://www.xxx.com/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("quota", "3000");
		sParaTemp.Add("return_url", "http://www.xxx.com/index.html");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("day_quota", "3800");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	public void queryWithholdAuthority()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "query_withhold_authority");
		sParaTemp.Add("auth_type", "ALL");
		sParaTemp.Add("identity_id", "20190409104630");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "http://www.xxx.com/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("return_url", "http://www.xxx.com/index.html");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("is_detail_disp", "Y");
		sParaTemp.Add("sign_type", "RSA");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	public void relieveWithholdAuthority()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "relieve_withhold_authority");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("identity_id", "1555051737809");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("return_url", "http://www.xxx.comindex.html");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "http://www.xxx.com/Notify");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("sign_type", "RSA");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	public void setMerchantConfig()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "set_merchant_config");
		sParaTemp.Add("config_value", "MEMBER_INFO_GENERAL_NOTIFY_URL");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "http://www.xxx.com/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("config_key", "MEMBER_INFO_GENERAL_NOTIFY_URL");
		sParaTemp.Add("return_url", "http://www.xxx.com/index.html");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("extend_param", "");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	public void queryMerchantConfig()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "query_merchant_config");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("config_key", "MEMBER_INFO_GENERAL_NOTIFY_URL");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("return_url", "http://www.xxx.com/index.html");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "http://www.xxx.com/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("sign_type", "RSA");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	public void merchantReport()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "merchant_report");
		sParaTemp.Add("contact_name", "sss");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("merchant_name", "sss");
		sParaTemp.Add("notify_url", "http://www.xxx.com/Notify");
		sParaTemp.Add("mcc", "");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("contact_identity", "02");
		sParaTemp.Add("custom_telephone", "0102523685");
		sParaTemp.Add("contact_type", "LEGAL_PERSON");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("merchant_identitiy_type", "UID");
		sParaTemp.Add("return_url", "http://www.xxx.com/index.html");
		sParaTemp.Add("merchant_identity_id", "20181012100627");
		sParaTemp.Add("short_name", "ss");
		sParaTemp.Add("report_org", "TENPAY");
		sParaTemp.Add("client_ip", "127.0.0.1");
		sParaTemp.Add("sign_type", "RSA");
		sParaTemp.Add("app_id", "sssssssssssssw");
		sParaTemp.Add("extend_param", "");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	
	public void smerchantUrlGet()
	{
		Dictionary<String, Object> sParaTemp = new Dictionary<String, Object>();
		sParaTemp.Add("service", "smerchant_url_get");
		sParaTemp.Add("member_type", "1");
		sParaTemp.Add("identity_id", "201904091107458");
		sParaTemp.Add("_input_charset", "utf-8");
		sParaTemp.Add("cashdesk_addr_category", "");
		sParaTemp.Add("memo", "");
		sParaTemp.Add("notify_url", "http://www.xxx.com/Notify");
		sParaTemp.Add("version", "1.2");
		sParaTemp.Add("request_time", "20190409110850");
		sParaTemp.Add("partner_id", "20000916888");
		sParaTemp.Add("return_url", "http://www.xxx.com/index.html");
		sParaTemp.Add("client_ip", "101.231.34.38");
		sParaTemp.Add("identity_type", "UID");
		sParaTemp.Add("sign_type", "RSA");
		SortedList<string, string> sinaSDK_result = com.sinapay.sinaSDK.mgs_sdk(sParaTemp);
		
	}
	public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}