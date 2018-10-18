using System;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Text;
using System.Security.Cryptography;
using com.sinapay;
using System.Collections.Specialized;
using System.Collections.Generic;
using System.Threading;
using System.Runtime.Remoting.Messaging;



public partial class notify : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       SortedList<string, string> pay_result = new SortedList<string, string>();
       LogClass notifylogs = new LogClass();
       notifylogs.WriteLogFile("异步入口：开始获取外部请求过来的数据：" + "POST请求过来的数据：" + Request.Form.ToString() + "----------GET请求过来的数据：" + Request.QueryString.ToString());
        for (int i = 0; i < Request.Form.Count; i++)
        {
            pay_result.Add(Request.Form.Keys[i].ToString(), Request.Form[i].ToString());
        }
        try
        {
            bool Check_SignMsg_result = com.sinapay.weibopayapi.Check_SignMsg(pay_result, pay_result["sign_type"], pay_result["sign"], pay_result["_input_charset"], notifylogs);
            if (Check_SignMsg_result)
            {
                try
                {
                    notifylogs.WriteLogFile("日志——验证新浪来源签名成功：新浪异步推送过来的报文是：" + new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(pay_result));
                    switch (pay_result["notify_type"])
                    {
                        case "trade_status_sync"://交易结果通知
                            //1.此处将pay_result LIST插入InsertInto trade_status_sync对应的数据库。无sql代码示例，以商户数据库为准。其他case雷同
                            //...sql...!
                            //2.更新数据以后做异步委托，必须在异步委托中处理自身的业务,不允许在此处做业务处理。正常收到数据后必须5秒内响应success。超时新浪视为推送失败，进入重试机制
                            AddHandler trade_status_sync_AsyncDelegate = new AddHandler(trade_status_sync_AsyncMethod);
                            IAsyncResult iAsyncRslt = trade_status_sync_AsyncDelegate.BeginInvoke(pay_result, notifylogs, new AsyncCallback(callback), notifylogs);
                            break;
                        case "refund_status_sync"://交易退款结果通知
                        case "deposit_status_sync"://充值结果通知
                            AddHandler deposit_status_synchandler = new AddHandler(deposit_status_sync_AsyncMethod);
                            IAsyncResult result = deposit_status_synchandler.BeginInvoke(pay_result, notifylogs, new AsyncCallback(callback), notifylogs);
                            break;
                        case "withdraw_status_sync"://出款结果通知
                            AddHandler withdraw_status_synchandler = new AddHandler(withdraw_status_syncAsyncMethod);
                            IAsyncResult withdraw_status_sync_result = withdraw_status_synchandler.BeginInvoke(pay_result, notifylogs, new AsyncCallback(callback), notifylogs);
                            break;
                        case "batch_trade_status_sync"://批量交易结果通知
                        case "audit_status_sync"://审核结果通知
                            AddHandler audit_status_synchandler = new AddHandler(audit_status_syncAsyncMethod);
                            IAsyncResult audit_status_sync_result = audit_status_synchandler.BeginInvoke(pay_result, notifylogs, new AsyncCallback(callback), notifylogs);
                            break;
                        case "bid_status_sync"://标的状态通知   
                            break;
                        case "mig_set_pay_password"://设置支付密码（会员信息综合通知）   
                            break;
                        case "mig_binding_card"://绑定银行卡（会员信息综合通知）
                            break;
                        case "mig_change_card"://换绑银行卡（会员信息综合通知）
                            break;
                        case "mig_unbind_card"://解绑银行卡（会员信息综合通知）
                            break;
                        case "mig_apply_withhold"://申请委托扣款（会员信息综合通知）
                            break;
                        case "mig_modify_withhold"://修改委托扣款（会员信息综合通知）
                            break;
                        case "mig_cancel_withhold"://取消委托扣款（会员信息综合通知）
                            break;
                    }
                    Response.Write("success");
                }
                catch(Exception exx)
                {   //如果插入数据库失败，请勿响应success，新浪会尝试最多七次，重发数据.中间只要响应success就不会再次重发数据
                    //SINA异步重试推送间隔 [[2, 10, 10, 60, 120, 360, 900]] 单位（分钟）
                    Response.Write("updata sql fail");
                    notifylogs.WriteLogFile(exx.ToString());
                }
            }
            else
            {   //校验签名验证数据失败,或KEY不正确，或数据在传输途中被篡改
                Response.Write("sign error!");
            }
        }
        catch (Exception exx)
        {//不正当来源数据。
            Response.Write("error!");
            notifylogs.WriteLogFile(exx.ToString(), LOGending: true);
        }
    }

    public delegate bool AddHandler(SortedList<string, string> pay_result, LogClass logs);
    public delegate int tradeAddHandler(SortedList<string, string> pay_result, LogClass logs);
    /// <summary>
    /// 交易结果通知异步委托的方式
    /// </summary>
    /// <param name="pay_result">SortedList</param>
    /// <param name="logs">日志class</param>
    /// <returns></returns>
    public bool trade_status_sync_AsyncMethod(SortedList<string, string> pay_result, LogClass notifylogs)
    {
        System.Diagnostics.Debug.WriteLine(DateTime.Now.ToString() + "/********进入异步方法调用区域********/");
        Thread.Sleep(8000);//测试异步委托，8秒。
        notifylogs.WriteLogFile("日志——开始异步委托取出数组模拟执行业务逻辑：" + new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(pay_result));
        return true;
    }
    /// <summary>
    /// 充值结果的异步委托的方式
    /// </summary>
    /// <param name="pay_result">SortedList</param>
    /// <param name="logs">日志class</param>
    /// <returns></returns>
    public bool deposit_status_sync_AsyncMethod(SortedList<string, string> pay_result, LogClass notifylogs)
    {
        System.Diagnostics.Debug.WriteLine(DateTime.Now.ToString() + "/********进入异步方法调用区域********/");
        Thread.Sleep(4000);//测试充值异步委托，3秒。
        notifylogs.WriteLogFile("日志——开始异步委托取出数组模拟执行业务逻辑：" + new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(pay_result));
        return true ;
    }
    /// <summary>
    /// 提现结果的异步委托的方式
    /// </summary>
    /// <param name="pay_result">SortedList</param>
    /// <param name="logs">日志class</param>
    /// <returns></returns>
    public bool withdraw_status_syncAsyncMethod(SortedList<string, string> pay_result, LogClass notifylogs)
    {
        System.Diagnostics.Debug.WriteLine(DateTime.Now.ToString() + "/********进入异步方法调用区域********/");
        Thread.Sleep(3000);//测试提现充值异步委托，3秒。
        notifylogs.WriteLogFile("日志——开始异步委托取出数组模拟执行业务逻辑：" + new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(pay_result));
        return true;
    }
    /// <summary>
    /// 企业会员审核结果的异步委托的方式
    /// </summary>
    /// <param name="pay_result">SortedList</param>
    /// <param name="logs">日志class</param>
    /// <returns></returns>
    public bool audit_status_syncAsyncMethod(SortedList<string, string> pay_result, LogClass notifylogs)
    {
        System.Diagnostics.Debug.WriteLine(DateTime.Now.ToString() + "/********进入异步方法调用区域********/");
        Thread.Sleep(3000);//测试企业会员审核结果异步委托，3秒。
        notifylogs.WriteLogFile("日志——开始异步委托取出数组模拟执行业务逻辑：" + new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(pay_result));
        return true;
    }
    static void callback(IAsyncResult result)
    {
        //result 是“deposit_status_sync_AsyncMethod()方法”的返回值
        //AsyncResult 是IAsyncResult接口的一个实现类，引用空间：System.Runtime.Remoting.Messaging
        //AsyncDelegate 属性可以强制转换为用户定义的委托的实际类。
        AddHandler handler = (AddHandler)((AsyncResult)result).AsyncDelegate;
        LogClass notifylogs = (LogClass)result.AsyncState;
        notifylogs.WriteLogFile("日志——异步委托执行结果是 ：" + handler.EndInvoke(result), LOGending: true);
    }
}

