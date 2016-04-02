//
//  ViewController.m
//  Demo4_JS_XML
//
//  Created by  江苏 on 16/3/10.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"
#import "JS_Music.h"
@interface ViewController ()
@property(nonatomic,strong)NSMutableArray* musics;
@property(nonatomic)JS_Music* jsmusic;
@property(nonatomic,copy)NSString* currentMusic;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.musics=[NSMutableArray array];
    NSData* musicData=[NSData dataWithContentsOfFile:@"/Users/jiangsu/Documents/IOS/UIKit Core/Day03/Demo4_JS_XML/Demo4_JS_XML/music.xml"];
    NSXMLParser* parser=[[NSXMLParser alloc]initWithData:musicData];
    parser.delegate=self;
    [parser parse];
    for (JS_Music* musicx in self.musics) {
        NSLog(@"%@",musicx);
    }
}
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    if ([elementName isEqualToString:@"music"]) {
        self.jsmusic=[[JS_Music alloc]init];
        [self.musics addObject:self.jsmusic];
    }
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    self.currentMusic=string;
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if ([elementName isEqualToString:@"name"]) {
        self.jsmusic.name=self.currentMusic;
    }else if ([elementName isEqualToString:@"zhuanji"]){
        self.jsmusic.zhuanji=self.currentMusic;
    }else if ([elementName isEqualToString:@"price"]){
        self.jsmusic.price=[self.currentMusic intValue];
    }else if ([elementName isEqualToString:@"time"]){
        self.jsmusic.time=[self.currentMusic intValue];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
