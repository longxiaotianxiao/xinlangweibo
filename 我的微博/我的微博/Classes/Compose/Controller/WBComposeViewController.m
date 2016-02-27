//
//  WBComposeViewController.m
//  我的微博
//
//  Created by wmd on 16/2/25.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "WBComposeViewController.h"
#import "WBTextView.h"
#import "WBComposeToolBar.h"
#import "WBComposePhotosView.h"
#import "WBComposeTool.h"
#import "MBProgressHUD+MJ.h"

@interface WBComposeViewController ()<UITextViewDelegate,WBComposeToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,weak) WBTextView *textView;
@property (nonatomic,weak) WBComposeToolBar *toolBar;
@property (nonatomic,weak) WBComposePhotosView *photosView;
@property (nonatomic,strong) UIBarButtonItem *rightItem;

@end

@implementation WBComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
//    设置导航条
    [self setUpNavigationBar];
//    添加Textiew
    [self setUpTextView];
//    添加工具条
    [self setUpToolBar];
//    监听键盘的弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
//    添加相册视图
    [self setUpPhotosView];
    
}
- (void)setUpPhotosView
{
    WBComposePhotosView *photoView = [[WBComposePhotosView alloc] initWithFrame:CGRectMake(0, 70, self.view.width, self.view.height-70)];
    
    
    [_textView addSubview:photoView];
    _photosView = photoView;
    
}
#pragma mark - 键盘的Frame改变的时候调用
- (void)keyboardFrameChange:(NSNotification *)note
{
    
    CGFloat durtion = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
//    获取键盘的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (frame.origin.y == self.view.height) {//没有弹出键盘
        [UIView animateWithDuration:durtion animations:^{
            _toolBar.transform = CGAffineTransformIdentity;
        }];
        
    }else{//弹出键盘
        [UIView animateWithDuration:durtion animations:^{
            _toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
        }];
        
    }
}
- (void)setUpToolBar
{
    CGFloat h = 35;
    CGFloat y = self.view.height - h;
    
    WBComposeToolBar *toolBar = [[WBComposeToolBar alloc] initWithFrame:CGRectMake(0, y, self.view.width, h)];
    
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    _toolBar = toolBar;
}
#pragma mark - ToolBar点击代理的实现
- (void)composeToolBar:(WBComposeToolBar *)toolbar didClickBtn:(NSInteger)index
{
    if (index == 0) {//点击相册
//        弹出系统的相册
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
//        设置相册类型
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:imagePicker animated:YES completion:nil];
        _rightItem.enabled = YES;
    }
}
#pragma mark - 相册选择的代理实现
//选择图片完成时调用
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    _photosView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)setUpTextView
{
    WBTextView *textView = [[WBTextView alloc] initWithFrame:self.view.bounds];
    
    textView.font = [UIFont systemFontOfSize:18];
//    设置占位符
    textView.placeHolder = @"分享新鲜事...";
    [self.view addSubview:textView];
//    默认可以垂直方向拖拽
    textView.alwaysBounceVertical = YES;
    _textView = textView;
//    监听文本框输入
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
//    监听拖拽
    _textView.delegate = self;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
#pragma mark - 文字改变的时候调用
- (void)textChange
{
//    判断textView有没有内容
    if (_textView.text.length) {
        _textView.hidePlaceHolder = YES;
        _rightItem.enabled = YES;
    }else{
        _textView.hidePlaceHolder = NO;
        _rightItem.enabled = NO;
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_textView becomeFirstResponder];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setUpNavigationBar
{
    self.title = @"发微博";
//    左侧
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style: 0 target:self action:@selector(dismiss)];
//    右侧
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn sizeToFit];
//   监听按钮点击
    [btn addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    rightItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = rightItem;
    _rightItem = rightItem;
}
- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 发送微博
- (void)compose
{
//    发送文字
    
    [WBComposeTool composeWithStatus:_textView.text success:^{
        NSLog(@"发送成功");
//        提示用户发送成功
        [MBProgressHUD showSuccess:@"发送成功"];
//        回到首页
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failture:^(NSError *error) {
        NSLog(@"%@",error);
        [MBProgressHUD showError:@"发送失败"];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
