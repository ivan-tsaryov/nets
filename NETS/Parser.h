//
//  Parser.h
//  NETS
//
//  Created by Ivan Tsaryov on 25/04/17.
//  Copyright © 2017 Hyperbolaxis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TFHppleElement;
@class AElement;

@interface Parser : NSObject

- (instancetype)initWithURL:(NSString *)URL;

- (NSArray<TFHppleElement *> *)parseImages;

- (NSArray<NSString *> *)parseKeywords;

- (NSArray<AElement *> *)parseListElements;

@end
