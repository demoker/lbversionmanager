# ABOUT #

路宝企业级App版本检测解决方案

### Features ###

* 支持应用唤醒自动检测
* 检测地址可配置
* 支持配置强制更新

### TODO ###

* 配置版本提示样式

### USAGE ###

[LBVersionManager setVersionInfoUrl:[NSURL URLWithString:@"https://app.lubaocar.com/iOS/LBDriver/release/update.json"]]; 

//指定升级信息json文件路径 

[LBVersionManager setInstallModel:YES]; 

//知否强制更新，如果强制更新，点击直接杀死应用 

-(void)checkUpatewhenSuccess:(VersionCheckSuccessCallback)success
                    andFailed:(VersionCheckFaildCallback)failed;//主动监测更新
 
### update.json 文件格式要求 ###
 
{  
   "updateTitle":"1.0.0",  
   "version": "1.0.0",  
   "updateInfo": ["beta version"],   
   "size": "18.6M",  
   "AppUrl": "itms-services://?action=download-manifest&url=https://app.lubaocar.com/iOS/LBDriver/release/LBDriver.plist"  
}