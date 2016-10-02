//
//  Customer.m
//  Per La Glory
//
//  Created by Sergey Shatalov on 08.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import "Customer.h"

NSString * const kCustomerIDKey = @"id";
NSString * const kCustomerNameKey = @"name";
NSString * const kCustomerIsActiveKey = @"isActive";
NSString * const kCustomerCreatedDateKey = @"createdDate";

@implementation Customer

- (instancetype)initWithDictionary:(NSDictionary *)dictInfo {
    self = [super init];
    
    if (self != nil) {
        if (![dictInfo isKindOfClass:[NSNull class]]) {
            self.name = dictInfo[kCustomerNameKey];
            self.id = dictInfo[kCustomerIDKey];
            self.isActive = [(NSNumber *)dictInfo[kCustomerIsActiveKey] boolValue];
            self.createdDate = dictInfo[kCustomerCreatedDateKey];
        }
    }
    
    return self;
}

@end
