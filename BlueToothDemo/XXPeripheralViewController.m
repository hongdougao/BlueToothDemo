//
//  XXPeripheralViewController.m
//  BlueToothDemo
//
//  Created by Yangyue on 15/6/8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "XXPeripheralViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#define myCustomUUidgen @"390046A5-D675-4928-908D-346A54C6C594"
@interface XXPeripheralViewController() <CBPeripheralDelegate,CBPeripheralManagerDelegate>
{
    CBUUID *myCustomServiceUUID;
    CBMutableCharacteristic *myCharacteristic;
    CBMutableService *mySerive;
    
    CBPeripheralManager *myPeripheralManager;
}
 @end

@implementation XXPeripheralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    myPeripheralManager = [[CBPeripheralManager alloc]initWithDelegate:self queue:nil];
    
    // Do any additional setup after loading the view.
    myCustomServiceUUID = [CBUUID UUIDWithString:myCustomUUidgen];
    
    NSString * str = @"hello  world! Who are you?";
    NSData * myValue = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    myCharacteristic = [[CBMutableCharacteristic alloc]initWithType:myCustomServiceUUID properties:CBCharacteristicPropertyRead value:myValue permissions:CBAttributePermissionsReadable];
    
    mySerive = [[CBMutableService alloc]initWithType:myCustomServiceUUID primary:YES];
    mySerive.characteristics = @[myCharacteristic];
    
    [myPeripheralManager addService:mySerive];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startClick:(id)sender {

    [myPeripheralManager startAdvertising:@{CBAdvertisementDataServiceUUIDsKey:@[mySerive.UUID,mySerive.UUID]}];
    
 }
- (IBAction)startTransfer:(id)sender {
    
}

#pragma  mark --  delegage
//如果没发布服务成功，会调用这个代理
-(void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error{
    if(error){
        NSLog(@"Error publish serive:%@",[error localizedDescription]);
     }
 }
-(void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error{
    if(error){
        NSLog(@"Error publish serive:%@",[error localizedDescription]);
    }

}
-(void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request{
    NSLog(@"外设接收到了请求：%s",__FUNCTION__);
    if ([request.characteristic.UUID isEqual:myCharacteristic.UUID]) {
        
    }
    
    if (request.offset > myCharacteristic.value.length) {
        [myPeripheralManager respondToRequest:request withResult:CBATTErrorInvalidOffset];
        
        request.value = [myCharacteristic.value subdataWithRange:NSMakeRange(request.offset, myCharacteristic.value.length -  request.offset)];//取得值
        
        [myPeripheralManager respondToRequest:request withResult:CBATTErrorSuccess];//回应请求
        
        //写特征
        myCharacteristic.value = request.value;
        
        NSMutableArray *requests;
        //发送一个数组 给请求
        [myPeripheralManager respondToRequest:[requests objectAtIndex:0] withResult:CBATTErrorSuccess];
        
        
        return;
    }

}
//信息被外设中心订阅时调用的方法 用这个方法像一个线索一样来更新中心设备的值
-(void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic{
    NSLog(@"central subscribed to chacteristic :%@",characteristic);
    
    NSString * str = @"updata value For central";
    NSData * updatedValue = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    BOOL didSendValue = [myPeripheralManager updateValue:updatedValue forCharacteristic:characteristic onSubscribedCentrals:nil];
    
    if (didSendValue) {
        NSLog(@"发送成功");
    }else{
        NSLog(@"发送失败");
    }
    
    
}
-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    /*	CBPeripheralManagerStateUnknown = 0,
     CBPeripheralManagerStateResetting,
     CBPeripheralManagerStateUnsupported,
     CBPeripheralManagerStateUnauthorized,
     CBPeripheralManagerStatePoweredOff,
     CBPeripheralManagerStatePoweredOn,
     */
    int state = peripheral.state;
    switch (state) {
        case CBPeripheralManagerStateUnknown:
            NSLog(@"state : CBPeripheralManagerStateUnknown");
            break;
        case CBPeripheralManagerStateResetting:
            NSLog(@"state : CBPeripheralManagerStateResetting");
            break;
        case CBPeripheralManagerStateUnsupported:
            NSLog(@"state : CBPeripheralManagerStateUnsupported");
            break;
        case CBPeripheralManagerStateUnauthorized:
            NSLog(@"state : CBPeripheralManagerStateUnauthorized");
            break;
        case CBPeripheralManagerStatePoweredOff:
            NSLog(@"state : CBPeripheralManagerStatePoweredOff");
            break;
        case CBPeripheralManagerStatePoweredOn:
            NSLog(@"state : CBPeripheralManagerStatePoweredOn");
            break;
        default:
            break;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
