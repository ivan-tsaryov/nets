//
//  ViewController.m
//  NETS
//
//  Created by Ivan Tsaryov on 25/04/17.
//  Copyright © 2017 Hyperbolaxis. All rights reserved.
//

#import "ViewController.h"
#import "Parser.h"
#import "Server.h"
#import "Client.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *messageTextField;

@property (strong, nonatomic) Parser *parser;

@property (strong, nonatomic) Server *server;

@property (strong, nonatomic) Client *client;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.parser = [[Parser alloc] initWithURL:@"http://convertmonster.ru/blog/seo-blog/meta-keywords-kljuchevye-slova-znachenie/"];
    __unused NSArray *array = [self.parser parseListElements];
    
    self.server = [Server new];
    
    self.client = [[Client alloc] initWithPort:8829];
    [self.client connect];
}

- (IBAction)onSendButtonClick:(UIButton *)sender {
    [self.client writeString:self.messageTextField.text withTag:0];
}

@end
