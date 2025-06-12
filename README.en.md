# location

#### Description [中文](README.md)
Harmony OS location

#### Software Architecture

Based on the system's positioning request library, the "Location" module is encapsulated.

#### Installation

`ohpm install @free/location`

#### Instruction Manual


1、Initialization
```
local:Location = new Location()

/**
 * Current location information
 * @returns geoLocationManager.Location
 */
this.local.currentLocation()
 
/**
 * Current "GCJ02" location information
 * @returns geoLocationManager.Location
 */
this.local.currentLocationGCJ02()

/**
 * Obtain positioning
 * @returns geoLocationManager.GeoAddress
 */
this.local.location()

/**
 * Obtain nearby location information
 * @returns Array<geoLocationManager.GeoAddress>
 */
this.local.locationList()

/**
 * Obtain nearby positioning based on latitude and longitude
 * @returns Array<geoLocationManager.GeoAddress>
 */
this.local.locationAddress()

/**
 * Get nearby location based on the address
 * description:string 
 * @returns Array<geoLocationManager.GeoAddress>
 */
this.local.locationAddressName()

/**
 * Obtain nearby location based on address or latitude/longitude coordinates
 * @returns Array<geoLocationManager.GeoAddress>
 */
this.local.locationAddressList()

/**
 * Transform GCJ02 positioning
 * @returns mapCommon.LatLng
 */
toGCJ02(latLong:mapCommon.LatLng)
```


#### Contribution

1.  Fork the repository
2.  Create Feat_xxx branch
3.  Commit your code
4.  Create Pull Request


#### Gitee Feature

1.  You can use Readme\_XXX.md to support different languages, such as Readme\_en.md, Readme\_zh.md
2.  Gitee blog [blog.gitee.com](https://blog.gitee.com)
3.  Explore open source project [https://gitee.com/explore](https://gitee.com/explore)
4.  The most valuable open source project [GVP](https://gitee.com/gvp)
5.  The manual of Gitee [https://gitee.com/help](https://gitee.com/help)
6.  The most popular members  [https://gitee.com/gitee-stars/](https://gitee.com/gitee-stars/)
