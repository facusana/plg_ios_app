//
//  Division.m
//  Per La Glory
//
//  Created by Sergey Shatalov on 08.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import "Division.h"
#import "Tactic.h"

NSString * const kDivisionIDKey = @"id";
NSString * const kDivisionNameKey = @"name";
NSString * const kDivisionIsActiveKey = @"isActive";
NSString * const kDivisionCreatedDateKey = @"createdDate";

@implementation Division

- (instancetype)initWithDictionary:(NSDictionary *)dictInfo {
    self = [super init];
    
    if (self != nil) {
        if (![dictInfo isKindOfClass:[NSNull class]]) {
            self.name = dictInfo[kDivisionNameKey];
            self.id = dictInfo[kDivisionIDKey];
            self.isActive = [(NSNumber *)dictInfo[kDivisionIsActiveKey] boolValue];
            self.createdDate = dictInfo[kDivisionCreatedDateKey];
        }
    }
    
    return self;
}

@end
