//
//  FixtureDate.h
//  Per La Glory
//
//  Created by Sergey Shatalov on 08.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Division.h"

@interface FixtureDate : NSObject

@property (nonatomic) NSNumber *id;
@property (nonatomic, strong)  Division *division;
@property (nonatomic, strong)  NSString *date;
@property (nonatomic, strong)  NSString *dateNumber;
@property (nonatomic, strong)  NSString *suspendedReason;
@property (nonatomic)          BOOL isSuspended;

- (instancetype)initWithDictionary:(NSDictionary *)dictInfo;

@end
