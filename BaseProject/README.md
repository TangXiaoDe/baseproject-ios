## iMeet

### Index

<a href="#link">一、常用链接</a><br/>
<a href="#config">二、配置说明</a><br/>
<a href="#special">三、特殊点</a><br/>
<a href="#specification">四、开发规范</a><br/>
<a href="#module">五、模块</a><br/>
<a href="#attention">六、注意事项</a><br/>

### <a name="link">一、常用链接</a>

* 原型图：[https://org.modao.cc/app/9599b328724c5e196c4aa18cb49125bd](https://org.modao.cc/app/9599b328724c5e196c4aa18cb49125bd)
* API：[https://comcfe.github.io/docs/api/imeet/](https://comcfe.github.io/docs/api/imeet/)
* GitHub-iOS：[https://github.com/CommunityChain/iMeet-iOS](https://github.com/CommunityChain/iMeet-iOS)
* 组件库ChainOneKit-Swift: [https://github.com/CommunityChain/ChainOneKit-Swift.git](https://github.com/CommunityChain/ChainOneKit-Swift.git)
* UI：蓝湖(iMeet)：[https://lanhuapp.com/](https://lanhuapp.com/)
* 项目管理：Teambition(iMeet-iOS开发)：[https://www.teambition.com](https://www.teambition.com)
* TestFlight: [https://testflight.apple.com/join/73plQ5wf](https://testflight.apple.com/join/73plQ5wf)
* FTP：[ftp://47.244.209.117:21](ftp://47.244.209.117:21) 
 * 用户名：zhaow/wanghj/liy/tangdg/duxx/zhangh
 * 密码：123456
* 项目验证码获取：[https://a.imeet.io/api/codes](https://a.imeet.io/api/codes)

### <a name="config">二、配置说明</a>

#### 1. 开发配置

##### 1.1 代码规范 - SwiftLint

* 配置文件：```.swiftlint.yml```
* 格式化化命令：```swiftlint autocorrect```
* 官网：[https://github.com/realm/SwiftLint](https://github.com/realm/SwiftLint)

##### 1.2 Git提交忽略 - GitIgnore

* 配置文件：```.gitignore```
* 官网：[https://www.gitignore.io/](https://www.gitignore.io/)

##### 1.2 Git Branch说明
* ```develop``` 开发分支
 * ```develop_featureA``` featureA的开发分支
 * ```develop_xiaode``` 用户xiaode的开发分支
* ```master``` 主分支
* ```release``` 发布分支(等同于主分支)

#### 2. 项目配置

##### 2.1 服务器配置

```
测试服后台 ：manage.imeet.io(无效)
测试服API ： api.imeet.io
正式服管理后台：dashboard.imeet.io(无效)
正式服API ： 
官网：www.imeet.io(无效)
```

##### 2.2 BundleId、AppScheme、Signing配置
* 测试服包名：io.imeettest.www 
* 正式服包名：com.immeet.www

#### 3. 三方配置(待完善)

##### 3.1 三方配置-测试服

* 防水墙账号

```
APP登录：
APP id：2071327063
App Secret Key：0hlq1PIPnXpdsYba8kzUhoQ**
APP注册获取短信
APP id：2008240996
App Secret Key：0cKITDivxTyuazZM1GYiyFA**
APP忘记密码：
APP id：2071184223
App Secret Key：0LAb8TtaIOhjUqd5hlNT1_Q**
APP短信验证码登录
APP id：2005975075
App Secret Key：07Pgs7f1Y9oFl-6USO20XUg**

web邀请注册
APP id：2020763090
App Secret Key：0VaKz15Skn8RCwynIMuBk3w**
```

* 环信后台账密：
 * ```xiaodehappy@foxmail.com```   
 * ```a123456```
 
* 环信配置

```
AppKey:1101180622177072#imeet
Orgname:1101180622177072
appname:imeet
Client ID:YXA6wvqbAHYiEem3V8szXzRl-Q
Client Secret:YXA6I9C1f5l6seTTGhEj7bNU7vgOZU4
```

* 环信系统账号信息

```
EASEMOB_SYSTEM  = aaaaaa
EASEMOB_MESSAGE = bbbbbb
EASEMOB_DYNAMIC = cccccc
```


##### 3.2 三方配置-正式服

高德地图key: 62a5a0112e036ac8affc7a72456eaff6

* 防水墙账号

```
APP登录：
APP id：2069058021
App Secret Key：0yVRCXmcVZUcB_4Dzuq3nQQ**

APP注册获取短信
APP id：2091630267
App Secret Key：0l7XrnmKlvvuLhdbqQxUqPw**

APP忘记密码：
APP id：2011238553
App Secret Key：0rDVO_C6sYWJ-xeU9EcDFJg**

APP短信验证码登录
APP id：2088166362
App Secret Key：0B5dY8E0lJf642fbZUmjoAw**

web邀请注册
APP id：2028207440
App Secret Key：0sk5r6I_3ioezYQxKR4OoCg**
```

* 环信账号配置: 

```
AppKey:1103190821047820#imeet
Orgname:1103190821047820
appname:imeet
Client ID:YXA6N30GK-AbQRiUzHZ1MIHO1Q
Client Secret:YXA6U5i7UFMVIp3CXghNDOzliUAwJBs
```

* 微信支付与分享公用，仅正式服可用

```
appid：wxbf1efa248a26b874
AppSecret：c912564aabfddabb45df35130151cfab
```


* 支付宝支付配置

```
ALY_APP_ID=2019061365568103
ALY_NOTIFY_URL=http://a.imeet.io/api/alipay/notify
```

* 微信支付配置

```
WX_APP_ID=wxcb480facccadf8d2
WX_APP_SECRET=a48e4d66c147aee3032efbf3523b929e
WX_MER_APP_EKY=z16aulps8xwj3khdm2g4e9b7tkqsw5ro
WX_MER_NUM=1525255131
WX_NOTIFY_URL=http://a.imeet.io/api/wxpay/notify
```

* 环信系统账号信息

```
EASEMOB_SYSTEM  = aaaaaa
EASEMOB_MESSAGE = bbbbbb
EASEMOB_DYNAMIC = cccccc
```


### <a name="special">三、特殊点</a>

#### 1. 特殊功能

* 聊天背景可以切换与自定义、
* 语言库可以切换、

* 部分主题：颜色、图标、背景，哪些位置，
    ThemeConfig
* 文字大小可以调整：哪些位置，调整方案，


* 组件化

#### 2. 一期内容变更部分 

```
群应用第一版只做 群公告，群签到
群红包，群收款，群相册，群投票，群活动，群文件后期再弄，第一版先不做
动态可能还有点儿调整先不动
群聊机器人一期先不做
<以上内容来自微信群聊天记录>
```

```
移动端聊天功能：
1.单聊，群聊功能（文字，图片，语音，个人名片，群名片）
2.群应用（群公告）
3.加群/好友 方式（验证消息，确认）
4.聊天内容长按对应操作
1.文字：复制，转发，收藏，删除，撤回
2.图片：转发，保存到相册，收藏，删除，撤回
设置->取消通用设置

API：
注册推荐用户：采用相同标签用户推荐
动态推荐用户：后台设置推荐，用户动态数，被点赞数，被收藏数，评论数
社群推荐：后台设置推荐，用户成员数量
社区推荐：后台设置社区排序，按照排序进行分页推荐
```

```
用户修改备注页 暂时只添加备注名即可。

用户二维码添加信息
{
    "name": "BeJson",
    "id": 1,
    "sex": 1,
    "avatar": "sss",
 "type": "MyInfo"
}
```

### <a name="specification">四、开发规范</a>

#### 1. Swift开发规范
* 请参考ChainOneKit中Swift开发规范(待完成)；

#### 2. 项目开发规范
* 请参考ChainOneKit中iOS项目开发规范(待完成)；

#### 3. Git使用规范
* 请参考ChainOneKit中Git使用规范(待完成)；


### <a name="module">五、模块</a>

#### 1. 模块划分 

```
LeftMenu
任务中心
我的
	我的资产
		我的矿石、我的矿力
	我的收藏
	我的二维码
	我的邀请: 邀请好友、邀请记录、邀请规则、填写邀请码、
设置
	个人资料、实名认证、账号与安全(手机绑定、登录密码、支付密码、授权)、隐私、通用、帮助中心、
	新消息设置、意见反馈、关于iMeet、
```

* 注：部分模块仅仅添加了主界面文件作为临时占位，之后根据需要调整；


* 部分模块命名
 * QuickNews - 快讯
 * Guide - 引导(新手引导 + 引导页)
 * Planet - 星球
 * Square - 广场
 * Mining - 挖矿
 * Group - 社群
 * Community - 社区


#### 2. 文件索引与简述
* 请参考文件列表文档(待完成)

#### 3. 特殊模块记录

对于部分特殊的模块，如需求特殊、实现特殊、或业务复杂等值得特殊注意的模块或功能点，进行记录，予以备案。


### <a name="attention">六、注意事项</a>

1. 初次Clone项目时需更新pod，因使用```.gitignore```忽略了pod相关；



