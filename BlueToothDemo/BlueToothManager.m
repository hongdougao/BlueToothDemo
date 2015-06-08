//
//  BlueToothManager.m
//  BlueToothDemo
//
//  Created by Yangyue on 15/6/8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BlueToothManager.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface  BlueToothManager()<CBCentralManagerDelegate>{
    /*外围设备和中央设备在CoreBluetooth中使用CBPeripheralManager和CBCentralManager表示。
     
     CBPeripheralManager：外围设备通常用于发布服务、生成数据、保存数据。外围设备发布并广播服务，告诉周围的中央设备它的可用服务和特征。
     
     CBCentralManager：中央设备使用外围设备的数据。中央设备扫描到外围设备后会就会试图建立连接，一旦连接成功就可以使用这些服务和特征。*/
}
@property (nonatomic,strong)CBCentralManager *cbCenteralMgr;

@property (nonatomic,strong)NSMutableArray *peripheralArray;//外设
@end


@implementation BlueToothManager

+ (BlueToothManager *)shareManager{
    static BlueToothManager *_shareManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _shareManager = [[BlueToothManager alloc]init];
        _shareManager.cbCenteralMgr = [[ CBCentralManager alloc]initWithDelegate:_shareManager queue:nil];
        _shareManager.peripheralArray = [NSMutableArray array];
    });
    
    return _shareManager;
}


- (void)startScranceAroundDeveice{
 
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:  [NSNumber numberWithBool:false],  CBCentralManagerScanOptionAllowDuplicatesKey,nil];
    [self.cbCenteralMgr  scanForPeripheralsWithServices:nil options:dic];
    
}
-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{

}

/*必须实现的代理*/
-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
     NSLog(@"central state:%ld",(long)central.state);
    NSString *state;
    switch (central.state) {
        case CBCentralManagerStateUnknown:
            state =@"CBCentralManagerStateUnknown";
            NSLog(@"CBCentralManagerStateUnknown");
            break;
        case CBCentralManagerStateResetting:
            state =@"CBCentralManagerStateResetting";

            NSLog(@"CBCentralManagerStateResetting");
            break;
        case CBCentralManagerStateUnsupported:
            state =@"CBCentralManagerStateUnsupported";

            NSLog(@"CBCentralManagerStateUnsupported");
            break;
        case CBCentralManagerStateUnauthorized:
            state =@"CBCentralManagerStateUnauthorized";

            NSLog(@"CBCentralManagerStateUnauthorized");
            break;
        case CBCentralManagerStatePoweredOff:
            state =@"CBCentralManagerStatePoweredOff";

            NSLog(@"CBCentralManagerStatePoweredOff");
            break;
        case CBCentralManagerStatePoweredOn:
            state =@"CBCentralManagerStatePoweredOn";

            NSLog(@"CBCentralManagerStatePoweredOn");
            break;
        default:
            break;
    }
    if (self.stateBlock) {
        self.stateBlock(state);
    }
}
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"%s peripherals :%@",__FUNCTION__ ,peripheral);

}
-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"%s peripherals :%@  error:%@",__FUNCTION__ ,peripheral,error);
}
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"%s peripherals :%@  error:%@",__FUNCTION__ ,peripheral,error);
 
}
-(void)centralManager:(CBCentralManager *)central didRetrieveConnectedPeripherals:(NSArray *)peripherals{
    NSLog(@"%s peripherals :%@",__FUNCTION__ ,peripherals);
}
-(void)centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray *)peripherals{

    NSLog(@"%s peripherals :%@",__FUNCTION__ ,peripherals);

}

-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    NSLog(@"advertisementData:%@",advertisementData);
    if (self.infoBlock) {
        self.infoBlock(advertisementData);
    }
    [self.cbCenteralMgr connectPeripheral:peripheral options:nil];

}
- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary *)dict{

    NSLog(@"%s dict:%@",__FUNCTION__,dict);
}
@end
