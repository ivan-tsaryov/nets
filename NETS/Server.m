//
//  Server.m
//  NETS
//
//  Created by Ivan Tsaryov on 26/04/17.
//  Copyright © 2017 Hyperbolaxis. All rights reserved.
//

#import "Server.h"
#import "GCDAsyncSocket.h"

@interface Server () <GCDAsyncSocketDelegate>

@property (strong, nonatomic) GCDAsyncSocket *listenSocket;

@property (strong, nonatomic) GCDAsyncSocket* clientSocket;

@end

@implementation Server

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

#pragma mark - Public

- (void)initialize
{
    self.listenSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
    NSError *error = nil;
    if (![self.listenSocket acceptOnPort:8829 error:&error]) {
        NSLog(@"I goofed: %@", error);
    }
}

- (void)socket:(GCDAsyncSocket *)sender didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
    // The "sender" parameter is the listenSocket we created.
    // The "newSocket" is a new instance of GCDAsyncSocket.
    // It represents the accepted incoming client connection.
    
    // Do server stuff with newSocket...
    
    NSLog(@"SERVER: Did accept new socket");
    
    self.clientSocket = newSocket;
    
    NSString *welcomMessage = @"Welcome to the server!\r\n";
    [newSocket writeData:[welcomMessage dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    
    [sender readDataWithTimeout:-1 tag:0];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"SERVER: Did disconnect with error: %@", [err localizedDescription]);
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"SERVER: Did write data");
    
    [sock readDataWithTimeout:-1 tag:0];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"SERVER: Did read data: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    
    [sock readDataWithTimeout:-1 tag:0];
}

@end
