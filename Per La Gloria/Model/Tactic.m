//
//  Tactic.m
//  Per La Glory
//
//  Created by Sergey Shatalov on 08.08.16.
//  Copyright © 2016 Sergey Shatalov. All rights reserved.
//

#import "Tactic.h"

NSString * const kTacticIDKey = @"id";
NSString * const kTacticCodeKey = @"code";
NSString * const kTacticDescriptionKey = @"description";

@implementation Tactic

- (instancetype)initWithDictionary:(NSDictionary *)dictInfo {
    self = [super init];
    
    if (self != nil) {
        if (![dictInfo isKindOfClass:[NSNull class]]) {
            self.id = dictInfo[kTacticIDKey];
            self.code = dictInfo[kTacticCodeKey];
            self.tacticDescription = dictInfo[kTacticDescriptionKey];
        }
    }
    return self;
}

@end
