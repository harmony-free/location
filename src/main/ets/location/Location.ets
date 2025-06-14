import { geoLocationManager } from '@kit.LocationKit'
import { BusinessError } from '@kit.BasicServicesKit';
import { map, mapCommon } from '@kit.MapKit';

export class Location{
  maxItems:number = 20
  timeOut:number = 8000
  type:mapCommon.CoordinateType = mapCommon.CoordinateType.WGS84;
  priority:geoLocationManager.LocatingPriority = geoLocationManager.LocatingPriority.PRIORITY_LOCATING_SPEED

  /**
   * 获取定位
   * @returns geoLocationManager.GeoAddress
   */
  async location(data?:string|mapCommon.LatLng|undefined): Promise<geoLocationManager.GeoAddress> {
    return new Promise<geoLocationManager.GeoAddress>((res, rej) => {
      try {
        if (data == undefined) {
          this.currentLocation().then((location)=>{
            this.locationAddress({latitude:location.latitude,longitude:location.longitude}).then((list)=>{
              if (list.length > 0) {
                res(list[0]);
              }else{
                console.error("errCode:" + "500" + ", message:"  + "数据为空");
                rej("errCode:" + "500" + ", message:"  + "数据为空");
              }
            })
          })
        }else {
          this.locationAddressList(data).then((list)=>{
            if (list.length > 0) {
              res(list[0]);
            }else{
              console.error("errCode:" + "500" + ", message:"  + "数据为空");
              rej("errCode:" + "500" + ", message:"  + "数据为空");
            }
          })
        }
      } catch (err) {
        console.error("errCode:" + err.code + ", message:"  + err.message);
        rej(err)
      }
    })
  }

  /**
   * 获取附近定位
   * @returns Array<geoLocationManager.GeoAddress>
   */
  async locationList(data?:string|mapCommon.LatLng|undefined): Promise<Array<geoLocationManager.GeoAddress>> {
    return new Promise<Array<geoLocationManager.GeoAddress>>((res, rej) => {
      try {
        if (data == undefined) {
          this.currentLocation().then((location)=>{
            this.locationAddress({latitude:location.latitude,longitude:location.longitude}).then((list)=>{
              res(list);
            })
          })
        }else {
          this.locationAddressList(data).then((list)=>{
            res(list);
          })
        }
      } catch (err) {
        console.error("errCode:" + err.code + ", message:"  + err.message);
        rej(err)
      }
    })
  }

  /**
   * 根据地址或经纬度 获取定位
   * @returns Array<geoLocationManager.GeoAddress>
   */
  async locationAddressList(data:string | mapCommon.LatLng): Promise<Array<geoLocationManager.GeoAddress>> {
    if (typeof  data == "string") {
      return this.locationAddressName(data);
    }else {
      return this.locationAddress(data)
    }
  }

  /**
   * 根据地址 获取定位
   * @returns Array<geoLocationManager.GeoAddress>
   */
  async locationAddressName(description:string): Promise<Array<geoLocationManager.GeoAddress>> {
    return new Promise<Array<geoLocationManager.GeoAddress>>(async (res, rej) => {
      let geocodeRequest:geoLocationManager.GeoCodeRequest = {
        locale: "zh",
        description: description,
        "maxItems": this.maxItems
      }
      try {
        geoLocationManager.getAddressesFromLocationName(geocodeRequest, (err, data) => {
          if (err) {
            console.error('getAddressesFromLocationName: err=' + JSON.stringify(err));
            rej(err)
          }
          if (data) {
            console.info('getAddressesFromLocationName: data=' + JSON.stringify(data));
            res(data)
          }
        });
      } catch (err) {
        console.error("errCode:" + err.code + ", message:"  + err.message);
        rej(err)
      }
    })
  }

  /**
   * 根据经纬度 获取定位
   * @returns Array<geoLocationManager.GeoAddress>
   */
  async locationAddress(data:mapCommon.LatLng): Promise<Array<geoLocationManager.GeoAddress>> {
    return new Promise<Array<geoLocationManager.GeoAddress>>(async (res, rej) => {
      let reverseGeocodeRequest:geoLocationManager.ReverseGeoCodeRequest = {"latitude": data.latitude, "longitude": data.longitude, "maxItems": this.maxItems};
      try {
        geoLocationManager.getAddressesFromLocation(reverseGeocodeRequest).then((data) => {
          console.info('getAddressesFromLocation: ' + JSON.stringify(data));
          res(data)
        })
      } catch (err) {
        console.error("errCode:" + err.code + ", message:"  + err.message);
        rej(err)
      }
    })
  }

  /**
   * 当前位置信息
   * @returns geoLocationManager.Location
   */
  async currentLocation(): Promise<geoLocationManager.Location> {
    return new Promise<geoLocationManager.Location>(async (res, rej) => {
      let request:geoLocationManager.SingleLocationRequest = {'locatingTimeoutMs': this.timeOut, 'locatingPriority': this.priority};
      let locationCallback = (err:BusinessError, location:geoLocationManager.Location):void => {
        if (err) {
          console.error('locationChanger: err=' + JSON.stringify(err));
          rej(err)
        }
        if (location) {
          console.info('locationChanger: location=' + JSON.stringify(location));
          res(location);
        }
      };

      try {
        geoLocationManager.getCurrentLocation(request, locationCallback);
      } catch (err) {
        console.error("errCode:" + err.code + ", message:"  + err.message);
        rej(err)
      }
    })
  }

  /**
   * 当前位置信息
   * @returns geoLocationManager.Location
   */
  async currentLocationGCJ02(): Promise<geoLocationManager.Location> {
    return new Promise<geoLocationManager.Location>(async (res, rej) => {
      let request:geoLocationManager.SingleLocationRequest = {'locatingTimeoutMs': this.timeOut, 'locatingPriority': this.priority};
      let locationCallback = (err:BusinessError, location:geoLocationManager.Location):void => {
        if (err) {
          console.error('locationChanger: err=' + JSON.stringify(err));
          rej(err)
        }
        if (location) {
          console.info('locationChanger: location=' + JSON.stringify(location));
          location = this.toGCJ02(location) as geoLocationManager.Location
          res(location);
        }
      };

      try {
        geoLocationManager.getCurrentLocation(request, locationCallback);
      } catch (err) {
        console.error("errCode:" + err.code + ", message:"  + err.message);
        rej(err)
      }
    })
  }

  toType(latLong:mapCommon.LatLng,type:mapCommon.CoordinateType):mapCommon.LatLng{
    if (type == mapCommon.CoordinateType.WGS84) {
      return this.toWGS84(latLong);
    }else{
      return this.toGCJ02(latLong);
    }
  }

  toGCJ02(latLong:mapCommon.LatLng):mapCommon.LatLng{
    return map.convertCoordinateSync(mapCommon.CoordinateType.WGS84, mapCommon.CoordinateType.GCJ02, latLong);
  }


  toWGS84(latLong:mapCommon.LatLng):mapCommon.LatLng{
    return map.convertCoordinateSync(mapCommon.CoordinateType.GCJ02, mapCommon.CoordinateType.WGS84, latLong);
  }

}