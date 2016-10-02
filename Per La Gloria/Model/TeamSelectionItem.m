//
//  TeamSelectionItem.m
//  Per La Gloria
//
//  Created by Sergey Shatalov on 10.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import "TeamSelectionItem.h"
NSString * const kTSIDKey = @"id";
NSString * const kTSNameKey = @"name";

@implementation TeamSelectionItem

- (instancetype)initWithDictionary:(NSDictionary *)dictInfo {
    self = [super init];
    
    if (self != nil) {
        if (![dictInfo isKindOfClass:[NSNull class]]) {
            self.name = dictInfo[kTSNameKey];
            self.id = dictInfo[kTSIDKey];
            self.isSelected = NO;
        }
    }
    
    return self;
}
@end
