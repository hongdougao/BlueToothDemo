//
//  XXPeripheralViewController.m
//  BlueToothDemo
//
//  Created by Yangyue on 15/6/8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "XXPeripheralViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface XXPeripheralViewController() <CBPeripheralDelegate,CBPeripheralManagerDelegate>

@property (nonatomic,strong)CBPeripheralManager *peripheralManager;
@end

@implementation XXPeripheralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startClick:(id)sender {
    _peripheralManager = [[CBPeripheralManager alloc]initWithDelegate:self queue:nil];
}
- (IBAction)startTransfer:(id)sender {
    
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
