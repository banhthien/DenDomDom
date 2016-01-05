//
//  CommentController.m
//  DenDomDom
//
//  Created by Thien Banh on 12/13/15.
//  Copyright (c) 2015 DiemMac. All rights reserved.
//

#import "CommentController.h"

@interface CommentController ()
{
    __weak IBOutlet UIWebView *oCommentView;
    
}
@end

@implementation CommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.mID = 1;
     [TFAppDelegate setNavigationTitle:@"BÌNH LUẬN" CanBack:YES ForController:self];
    NSString *urlString =@"https://www.facebook.com/plugins/comments.php?api_key=418700904999948&channel_url=http%3A%2F%2Fstatic.ak.facebook.com%2Fconnect%2Fxd_arbiter%2FTlA_zCeMkxl.js%3Fversion%3D41%23cb%3Df2a4434914%26domain%3Ddendomdom-hadiem.rhcloud.com%26origin%3Dhttp%253A%252F%252Fdendomdom-hadiem.rhcloud.com%252Ffb8cdd80%26relation%3Dparent.parent&href=http%3A%2F%2Fdendomdom-hadiem.rhcloud.com%2Fall%3Fid%3D";
    NSString *midString = [NSString stringWithFormat:@"%i&locale=vi_VN&mobile=false&numposts=5&sdk=joey&version=v2.5&width=100",(int)self.mID];
    NSString *endString =@"%25&__mref=message_bubble";
    NSString *finalString = [NSString stringWithFormat:@"%@%@%@", urlString, midString,endString];
    [oCommentView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:finalString]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionBackButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
