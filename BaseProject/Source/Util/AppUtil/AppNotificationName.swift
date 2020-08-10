//
//  AppNotificationName.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/26.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  通知的统一管理

import Foundation

typealias AppNotificationName = Notification.Name
extension Notification.Name {

    /// 消息
    struct Message {
        /// 未读消息
        static let unread = NSNotification.Name(rawValue: "app.notification.name.message.unread")
        /// 刷新未读消息
        static let refresh = NSNotification.Name(rawValue: "app.notification.name.message.refresh")
        /// 系统消息
        static let system = NSNotification.Name(rawValue: "app.notification.name.message.system")
        /// 普通消息
        static let message = NSNotification.Name(rawValue: "app.notification.name.message.message")
        /// 动态消息
        static let dynamic = NSNotification.Name(rawValue: "app.notification.name.message.dynamic")
        /// 新动态消息
        static let newDynamic = NSNotification.Name(rawValue: "app.notification.name.message.newDynamic")
    }

    /// Tabbar跳转
    struct Tabbar {
        static let doubleTap = NSNotification.Name(rawValue: "app.notification.name.tabbar.doubleTap")

        static let imeet = NSNotification.Name(rawValue: "app.notification.name.tabbar.imeet")
        static let meet = NSNotification.Name(rawValue: "app.notification.name.tabbar.meet")
        /// 广场
        static let square = NSNotification.Name(rawValue: "app.notification.name.tabbar.square")
        /// 任务
        static let task = NSNotification.Name(rawValue: "app.notification.name.tabbar.task")
        /// 挖矿
        static let mining = NSNotification.Name(rawValue: "app.notification.name.tabbar.mining")
        /// 星球
        static let planet = NSNotification.Name(rawValue: "app.notification.name.tabbar.planet")
    }

    /// 动态
    struct Moment {
        /// 删除(成功)
        static let delete = NSNotification.Name(rawValue: "app.notification.name.moment.delete")
        /// 发布(成功)
        static let publish = NSNotification.Name(rawValue: "app.notification.name.moment.publish")
        /// 点赞
        static let favor = NSNotification.Name(rawValue: "app.notification.name.moment.favor")
        /// 取消点赞
        static let unfavor = NSNotification.Name(rawValue: "app.notification.name.moment.unfavor")
        /// 收藏
        static let collect = NSNotification.Name(rawValue: "app.notification.name.moment.collect")
        /// 取消收藏
        static let uncollect = NSNotification.Name(rawValue: "app.notification.name.moment.uncollect")
        /// 评论点赞
        static let commentFavor = NSNotification.Name(rawValue: "app.notification.name.moment.comment.favor")
        /// 评论取消点赞
        static let commentUnfavor = NSNotification.Name(rawValue: "app.notification.name.moment.comment.unfavor")
    }

    /// 广告
    static let AdvertClick = NSNotification.Name(rawValue: "app.notification.name.advert.click")

    /// 用户
    struct User {
        /// 用户点击(头像、名字、等) - 资料页响应 - 默认
        static let click = NSNotification.Name(rawValue: "app.notification.name.user.click")
        /// 头像点击 - 主页响应
        static let ClickForHome = NSNotification.Name(rawValue: "app.notification.name.user.clickforhome")
        /// 动态屏蔽(不看TA的动态)
        static let momentShield = NSNotification.Name(rawValue: "app.notification.name.user.momentshield")
        /// 头像修改
        static let avatarUpdate = NSNotification.Name(rawValue: "app.notification.name.user.avatarupdate")

        /// 实名认证提交
        static let certSubmit = NSNotification.Name(rawValue: "app.notification.name.user.certSubmit")
    }

    /// 支付密码
    struct PayPwd {
        /// 重置成功
        static let resetSuccess = NSNotification.Name(rawValue: "app.notification.name.paypwd.resetsuccess")
    }

    /// 推送
    struct APNS {
        /// 推送点击
        static let click = NSNotification.Name(rawValue: "app.notification.name.apns.click")
        /// 推送启动
        static let launch = NSNotification.Name(rawValue: "app.notification.name.apns.launch")
    }

    /// App - App进入前台和后台都有系统通知
    struct App {
        /// 进入后台
        static let enterBackground = NSNotification.Name(rawValue: "app.notification.name.app.enterbackground")
        /// 进入前台
        static let enterForeground = NSNotification.Name(rawValue: "app.notification.name.app.enterforeground")

        /// 显示左侧弹窗
        static let showLeftMenu = NSNotification.Name(rawValue: "app.notification.name.app.showleftmenu")

        /// 获取系统配置
        static let getSystemConfig = NSNotification.Name(rawValue: "app.notification.name.app.getsystemconfig")
    }

    /// 邀请
    struct Invite {
        /// 一级好友点击
        static let firstFriendTap = NSNotification.Name(rawValue: "app.notification.name.invite.firstfriendtap")
    }

    /// 支付
    struct Pay {
        /// 支付宝支付成功
        static let alipaySuccess = NSNotification.Name(rawValue: "app.notification.name.pay.alipaysuccess")
        /// 微信支付成功
        static let wechatPaySuccess = NSNotification.Name(rawValue: "app.notification.name.pay.wechatpaysuccess")
    }

    /// 列表刷新相关
    struct Apply {
        /// 同意添加好友
        static let agreeFriend = NSNotification.Name(rawValue: "app.notification.name.Apply.agreeFriend")
        /// 删除好友
        static let deleteFriend = NSNotification.Name(rawValue: "app.notification.name.Apply.deleteFriend")
        /// 申请添加好友
        static let addFriend = NSNotification.Name(rawValue: "app.notification.name.Apply.addFriend")
        /// 好友分组更新
        static let updateFriendGroup = NSNotification.Name(rawValue: "app.notification.name.Apply.updateFriendGroup")
    }
    /// 创建社区/群
    struct Create {
        // TODO: - 待移除
        /// 同意添加好友
        static let group = NSNotification.Name(rawValue: "app.notification.name.Create.group")
        /// 申请删除
        static let community = NSNotification.Name(rawValue: "app.notification.name.Create.community")
    }

    /// 社群
    struct Group {
        // TODO: - 待移除
        /// 社群退出
        static let Withdraw = NSNotification.Name(rawValue: "app.notification.name.group.withdraw")
        /// 社群解散
        static let Disband = NSNotification.Name(rawValue: "app.notification.name.group.disband")
        /// 社群转让
        static let Transfer = NSNotification.Name(rawValue: "app.notification.name.group.transfer")

        /// 社群列表更新：社群创建、社群编辑、社群解散、社群退出、社群转让、被加入新社群
        static let list_update = NSNotification.Name(rawValue: "app.notification.name.group.list.update")
        /// 社群封禁
        static let forbidden = NSNotification.Name(rawValue: "app.notification.name.group.forbidden")
    }

    /// 社区
    struct Community {
        /// 社区列表更新
        static let ListUpdate = NSNotification.Name(rawValue: "app.notification.name.community.listupdate")
    }

    /// 好友
    struct Friend {
        /// 分组更新(分组列表)：分组操作(增、删、改)、好友操作(新增、删除、分组更换、拉黑与取消拉黑、好友申请拒绝(拒绝会拉黑))、
        static let groupUpdate = NSNotification.Name(rawValue: "app.notification.name.friend.groupupdate")
        /// 通讯录更新(通讯录列表)：别名更新、好友操作(新增、删除、拉黑与取消拉黑）
        static let contactUpdate = NSNotification.Name(rawValue: "app.notification.name.friend.groupupdate")
    }



    /// 申请入群
    struct JoinGroup {
        /// 同意申请/拒绝申请
        static let update = NSNotification.Name(rawValue: "app.notification.name.JoinGroup.update")
    }

    /// 公告
    struct Notice {
        /// 发布公告
        static let publish = NSNotification.Name(rawValue: "app.notification.name.Notice.publish")
        /// 删除公告
        static let delete = NSNotification.Name(rawValue: "app.notification.name.Notice.delete")
    }
    /// 红包
    struct RedEnvelop {
        /// 发红包
        static let send = NSNotification.Name(rawValue: "app.notification.name.RedEnvelop.send")
        /// 红包tip
        static let tips = NSNotification.Name(rawValue: "app.notification.name.RedEnvelop.tips")
    }

    /// 置顶
    struct Top {
        /// 置顶群
        static let group = NSNotification.Name(rawValue: "app.notification.name.Top.group")
        /// 置顶人
        static let user = NSNotification.Name(rawValue: "app.notification.name.Top.user")
    }
    /// 免打扰
    struct Bother {
        /// 置顶群
        static let group = NSNotification.Name(rawValue: "app.notification.name.Bother.group")
        /// 置顶人
        static let user = NSNotification.Name(rawValue: "app.notification.name.Bother.user")
    }
    /// 红点
    struct UnRead {
        /// 消息
        static let message = NSNotification.Name(rawValue: "app.notification.name.UnRead.message")
        /// 新朋友
        static let friend = NSNotification.Name(rawValue: "app.notification.name.UnRead.friend")
    }

    /// 广场任务
    struct SquareTask {
        /// 接任务
        static let accept = NSNotification.Name(rawValue: "app.notification.name.SquareTask.accept")
        /// 提交任务
        static let submit = NSNotification.Name(rawValue: "app.notification.name.SquareTask.submit")
    }

    /// 群名片
    struct GroupCard {
        /// 发送名片到当前会话
        static let currentSession = NSNotification.Name(rawValue: "app.notification.name.GroupNotice.current")
        /// 分享 好友/群 到指定会话
        static let otherSession = NSNotification.Name(rawValue: "app.notification.name.GroupNotice.other")
    }

    /// 会话
    struct Session {
        /// 删除指定会话
        static let delete = NSNotification.Name(rawValue: "app.notification.name.Session.delete")

        static let updateAlias = NSNotification.Name(rawValue: "app.notification.name.Session.alias")

        /// 清空聊天记录
        static let clear = NSNotification.Name(rawValue: "app.notification.name.Session.clear")
    }
    /// 背景
    struct Bg {
        /// 好友背景
        static let friendBg = NSNotification.Name(rawValue: "app.notification.name.friend.bg")

        static let groupBg = NSNotification.Name(rawValue: "app.notification.name.group.bg")
    }

    /// 禁言
    struct Silence {
        /// 禁言变化
        static let update = NSNotification.Name(rawValue: "app.notification.name.silence.update")
    }
    /// 转账
    struct Transfer {
        /// 转账成功通知
        static let success = NSNotification.Name(rawValue: "app.notification.name.transfer.success")
        /// 转账成功刷新聊天界面
        static let successReload = NSNotification.Name(rawValue: "app.notification.name.transfer.successReload")
    }

    /// 图片长按识别二维码成功
    static let PictureLongPressQRCode = NSNotification.Name(rawValue: "app.notification.name.picture.longpress.qrcode")

}
