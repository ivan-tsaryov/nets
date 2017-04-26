//
//  Client.h
//  NETS
//
//  Created by Ivan Tsaryov on 26/04/17.
//  Copyright © 2017 Hyperbolaxis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Client : NSObject

- (instancetype)initWithPort:(NSInteger)port;

- (void)writeString:(NSString *)string withTag:(NSInteger)tag;

- (void)connect;

@end
