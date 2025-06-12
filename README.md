# location

#### 介绍 [English](README.en.md)
Harmony OS location 鸿蒙定位库

#### 软件架构

基于系统定位请求库 Location 封装。

#### 安装教程

`ohpm install @free/location`

#### 使用说明

1、初始化
```
local:Location = new Location()

/**
 * 当前位置信息
 * @returns geoLocationManager.Location
 */
this.local.currentLocation()
 
/**
 * 当前GCJ02位置信息
 * @returns geoLocationManager.Location
 */
this.local.currentLocationGCJ02()

/**
 * 获取定位
 * @returns geoLocationManager.GeoAddress
 */
this.local.location()

/**
 * 获取附近定位
 * @returns Array<geoLocationManager.GeoAddress>
 */
this.local.locationList()

/**
 * 根据经纬度 获取附近定位
 * @returns Array<geoLocationManager.GeoAddress>
 */
this.local.locationAddress()

/**
 * 根据地址 获取附近定位
 * description:string 
 * @returns Array<geoLocationManager.GeoAddress>
 */
this.local.locationAddressName()

/**
 * 根据地址或经纬度 获取附近定位
 * @returns Array<geoLocationManager.GeoAddress>
 */
this.local.locationAddressList()

/**
 * 转化GCJ02定位
 * @returns mapCommon.LatLng
 */
toGCJ02(latLong:mapCommon.LatLng)
```

#### 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request


#### 特技

1.  使用 Readme\_XXX.md 来支持不同的语言，例如 Readme\_en.md, Readme\_zh.md
2.  Gitee 官方博客 [blog.gitee.com](https://blog.gitee.com)
3.  你可以 [https://gitee.com/explore](https://gitee.com/explore) 这个地址来了解 Gitee 上的优秀开源项目
4.  [GVP](https://gitee.com/gvp) 全称是 Gitee 最有价值开源项目，是综合评定出的优秀开源项目
5.  Gitee 官方提供的使用手册 [https://gitee.com/help](https://gitee.com/help)
6.  Gitee 封面人物是一档用来展示 Gitee 会员风采的栏目 [https://gitee.com/gitee-stars/](https://gitee.com/gitee-stars/)
