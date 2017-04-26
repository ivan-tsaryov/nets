//
//  Client.m
//  NETS
//
//  Created by Ivan Tsaryov on 26/04/17.
//  Copyright © 2017 Hyperbolaxis. All rights reserved.
//

#import "Client.h"

// GCD
#import "GCDAsyncSocket.h"

@interface Client () <GCDAsyncSocketDelegate>

@property (nonatomic) NSInteger port;

@property (strong, nonatomic) GCDAsyncSocket *socket;

@property (strong, nonatomic) NSMutableData *sendingData;

@end

@implementation Client

- (instancetype)initWithPort:(NSInteger)port
{
    self = [super init];
    
    if (self) {
        self.port = port;
    }
    
    return self;
}

#pragma mark - Public

- (void)connect
{
    self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self
                                             delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
    NSError *error = nil;
    [self.socket connectToHost:@"localhost" onPort:self.port withTimeout:15 error:&error];
}

- (void)writeString:(NSString *)string withTag:(NSInteger)tag
{
    self.sendingData = [[string dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
    
    [self.socket writeData:self.sendingData withTimeout:-1 tag:tag];
}

#pragma mark - GCDAsyncSocket Delegate

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"CLIENT: Successful connected to host");
    
    [sock readDataWithTimeout:-1 tag:0];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"CLIENT: Did disconnect with error: %@", [err localizedDescription]);
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"CLIENT: Did write data");
    
    [sock readDataWithTimeout:-1 tag:0];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"CLIENT: Did read data: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    
    [sock readDataWithTimeout:-1 tag:0];
}

@end
