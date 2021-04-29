# GeohashTile移植

## 代码

https://github.com/oscourse-tsinghua/undergraduate-dbin2021/tree/main/src/smart_contract

## 移植过程

### 文件替换

- 将李炜琪代码中的`geohash.js`替换为新代码中的`geohash-new.js`

- 补充其他缺少的代码文件

### 修改`traffic.html`

- 修改文件开头的`<style>`标签及脚本文件引用

```
<script src="leaflet-src-Geohash.js"></script>
<script src="leaflet.label-src.js"></script>
<script src="leaflet.label.js"></script>
<script src="OSMBuildings-Leaflet.debug.js"></script>

<script src="/usr/lib/node_modules/web3/dist/web3.min.js"></script>
<script src="./geohash-new.js"></script>
<script src="./geolib.js"></script>
<script src="./common.js"></script>
<script src="GeohashLayer.GeoJSON.js"></script>
<script src="https://s3.pstatp.com/cdn/expire-1-M/jquery/3.2.1/jquery.min.js"></script>

<script src="./gpsarray.js"></script>
<script src="./waysall.js"></script>
```

- 修改`calcNext()`函数中在地图上绘制点的方法

```
async function calcNext() {
	var geohash = locBuffer[nowCalc];
	// 原来的方法（添加原始数据点）
	// var range = decode_geohash(geohash);
	// var midLat = (range[2] + range[3]) / 2;
	// var midLon = (range[0] + range[1]) / 2;
	// var point = L.circle([midLat,midLon],3,{color:'#FF0000',fillColor:'#FF0000',fillOpacity:1});
	// 现在的方法
	var point = L.polyline([geohash,geohash],{color:'#FF0000',fillColor:'#FF0000',fillOpacity:1});
	map.addLayer(point);

	match(nowCalc);
	// 原来的方法（添加修正后数据点）
	// var range = decode_geohash(locBufferFix[nowCalc]);
	// var midLat = (range[2] + range[3]) / 2;
	// var midLon = (range[0] + range[1]) / 2;		
	// var point = L.circle([midLat,midLon],3,{color:'#00FF00',fillColor:'#00FF00',fillOpacity:1});
	// 现在的方法
	var newgeohash = locBufferFix[nowCalc];	
	var point = L.polyline([newgeohash,newgeohash],{color:'#00FF00',fillColor:'#00FF00',fillOpacity:1});
	map.addLayer(point);
	
	//...
}
```

- 删去原文件中有关地图显示的代码（在靠近文件末尾的部分）

```
<div id="mapDiv" style="width:1600px; height:1000px"></div>
<script>
	// ...
	// 删去以下部分
	initLeaflet();
	function initLeaflet() {
    map = L.map("mapDiv").setView([39.95844857,116.31668809],13);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',{attribution:'&copy; <a 	href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'}).addTo(map);	
}
</script>
```

- 在原文件最后的`<script>`标签结束后，添加董斌仓库文件中地图显示相关代码（也在文件最后）

```
<div id="map"></div>	
<script>
// ...
</script>
```

## 效果示意

![image-20210429150449604](C:\Users\Nancy\AppData\Roaming\Typora\typora-user-images\image-20210429150449604.png)

## 注意

- 目前与信誉计算部分没有冲突

- 在有鼠标或键盘干扰时，地图显示部分会报如下错误：

  ![image-20210429150358032](C:\Users\Nancy\AppData\Roaming\Typora\typora-user-images\image-20210429150358032.png)

  可能与缩放功能相关