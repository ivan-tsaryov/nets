//
//  AElement.h
//  NETS
//
//  Created by Ivan Tsaryov on 26/04/17.
//  Copyright © 2017 Hyperbolaxis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TFHppleElement;

@interface AElement : NSObject

@property (strong, readonly, nonatomic) TFHppleElement *element;

@property (strong, readonly, nonatomic) NSString *listType;

- (instancetype)initWithTFHppleElement:(TFHppleElement *)element listType:(NSString *)listType;

@end
