//
//  BlueToothManager.h
//  BlueToothDemo
//
//  Created by Yangyue on 15/6/8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BlueToothManager : NSObject

@property (nonatomic,copy)void(^stateBlock)(NSString *state);
@property (nonatomic,copy)void(^infoBlock)(NSDictionary *info);
 + (BlueToothManager *)shareManager;

- (void)startScranceAroundDeveice;

@end
