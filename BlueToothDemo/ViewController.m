//
//  ViewController.m
//  BlueToothDemo
//
//  Created by Yangyue on 15/6/8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ViewController.h"

#import "BlueToothManager.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *stateLbl;
@property (weak, nonatomic) IBOutlet UILabel *infoLbl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[BlueToothManager shareManager] setStateBlock:^(NSString * state) {
        self.stateLbl.text = state;
    }];
    
    [[BlueToothManager shareManager]setInfoBlock:^(NSDictionary *info) {
        self.infoLbl.text = [NSString stringWithFormat:@"kCBAdvDataIsConnectable: %@ kCBAdvDataLocalName: %@ kCBAdvDataManufacturerData: %@ kCBAdvDataServiceUUIDs:%@",info[@"kCBAdvDataIsConnectable"],info[@"kCBAdvDataLocalName"],info[@"kCBAdvDataManufacturerData"],info[@"kCBAdvDataServiceUUIDs"]];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)scan:(id)sender {
    NSLog(@"touche scane");
    [[BlueToothManager shareManager]startScranceAroundDeveice];
}
- (IBAction)content:(id)sender {
    
 }

@end
