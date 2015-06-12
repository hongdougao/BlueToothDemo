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
