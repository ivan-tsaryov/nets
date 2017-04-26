//
//  Parser.m
//  NETS
//
//  Created by Ivan Tsaryov on 25/04/17.
//  Copyright © 2017 Hyperbolaxis. All rights reserved.
//

#import "Parser.h"
#import "TFHpple.h"
#import "AElement.h"

@interface Parser ()

@property (strong, nonatomic) NSString *URL;

@end

@implementation Parser

- (instancetype)initWithURL:(NSString *)URL
{
    self = [super init];
    
    if (self) {
        self.URL = URL;
    }
    
    return self;
}

#pragma mark - Public

- (NSArray<TFHppleElement *> *)parseImages
{
    NSData *data = [self dataWithContents];
    
    TFHpple *doc = [[TFHpple alloc] initWithHTMLData:data];
    
    NSArray *elements = [doc searchWithXPathQuery:@"//img"];
    
    for (TFHppleElement *element in elements) {
        NSLog(@"%@", element.attributes);
    }
    
    return elements;
}

- (NSArray<NSString *> *)parseKeywords
{
    NSData *data = [self dataWithContents];
    
    TFHpple *doc = [[TFHpple alloc] initWithHTMLData:data];
    
    NSArray *elements = [doc searchWithXPathQuery:@"//meta"];
    
    NSArray<NSString *> *keywords = [NSArray new];
    
    for (TFHppleElement *element in elements) {
        NSString *kw = element.attributes[@"name"];
        
        if ([kw isEqualToString:@"keywords"]) {
            NSString *content = element.attributes[@"content"];
            
            keywords = [content componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        }
    }
    
    return keywords;
}

- (NSArray<AElement *> *)parseListElements
{
    NSData *data = [self dataWithContents];
    
    TFHpple *doc = [[TFHpple alloc] initWithHTMLData:data];
    
    NSArray *ulList = [doc searchWithXPathQuery:@"//ul"];
    NSArray *olList = [doc searchWithXPathQuery:@"//ol"];
    
    NSMutableArray<AElement *> *aElements = [NSMutableArray new];
    
    for (TFHppleElement *element in ulList) {
        [aElements addObject:[[AElement alloc] initWithTFHppleElement:element listType:@"u"]];
    }
    
    for (TFHppleElement *element in olList) {
        [aElements addObject:[[AElement alloc] initWithTFHppleElement:element listType:@"o"]];
    }
    
    return aElements;
}

#pragma mark - Private

- (NSData *)dataWithContents
{
    NSURL *url = [NSURL URLWithString:self.URL];
    NSError *error = nil;
    
    NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    } else {
        NSLog(@"Data has loaded successfully.");
    }
    
    return data;
}

@end
