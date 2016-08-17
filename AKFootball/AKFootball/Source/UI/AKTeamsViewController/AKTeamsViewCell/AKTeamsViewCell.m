//
//  AKTeamsViewCell.m
//  AKFootball
//
//  Created by Admin on 11.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKTeamsViewCell.h"
#import "AKTeam.h"
#import "AKImageView.h"

@implementation AKTeamsViewCell

#pragma mark -
#pragma mark Public

- (void)fillWithModel:(AKTeam *)team {
    
    self.cellLabel.text = team.name;
    
    //    if ([[URLString substringFromIndex:[URLString length] - 3]  isEqual: @"svg"]) {
    //        NSLog(@"EQUAL");
    //        return;
    //    }
    //    self.cellImageView.URL = [NSURL URLWithString:team.pictureURLPath];
    
    //NSString *path = team.pictureURLPath;
    //http://vignette1.wikia.nocookie.net/education/images/1/17/Yin_yang.svg

    
    self.cellLabel.text = team.name;
    if (team.pictureURLPath == nil) {
        self.noLogoImageView.image = [UIImage imageNamed:@"noLogo"];
    } else {
        NSString *URLString = team.pictureURLPath;
        if ([[URLString substringFromIndex:[URLString length] - 3]  isEqual:@"svg"]) {
            NSLog(@"EQUAL");
            NSURL *fileURL =[[NSURL alloc] initWithString:team.pictureURLPath];
            NSURLRequest *req =[NSURLRequest requestWithURL:fileURL];
            
            [self.imageWebView setScalesPageToFit:YES];
            [self.imageWebView loadRequest:req];
            self.imageWebView.delegate = self;
            self.cellImageView = nil;
        } else {
            self.cellImageView.URL = [NSURL URLWithString:team.pictureURLPath];
        }
    }
}

#pragma mark -
#pragma mark UIWebViewDelegate Protocol

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    CGSize contentSize = webView.scrollView.contentSize;
    CGSize webViewSize = webView.bounds.size;
    CGFloat scaleFactor = webViewSize.width / contentSize.width;
    
    webView.scrollView.minimumZoomScale = scaleFactor;
    webView.scrollView.maximumZoomScale = scaleFactor;
    webView.scrollView.zoomScale = scaleFactor;
}

@end