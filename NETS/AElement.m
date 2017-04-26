//
//  AElement.m
//  NETS
//
//  Created by Ivan Tsaryov on 26/04/17.
//  Copyright © 2017 Hyperbolaxis. All rights reserved.
//

#import "AElement.h"
#import "TFHpple.h"

@interface AElement ()

@property (strong, nonatomic) TFHppleElement *element;

@property (strong, nonatomic) NSString *listType;

@end

@implementation AElement

- (instancetype)initWithTFHppleElement:(TFHppleElement *)element listType:(NSString *)listType
{
    self = [super init];
    
    if (self) {
        self.element = element;
        self.listType = listType;
    }
    
    return self;
}

@end
