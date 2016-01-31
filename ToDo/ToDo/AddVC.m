//
//  AddVC.m
//  ToDo
//
//  Created by qingyun on 16/1/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "AddVC.h"
#import "Common.h"

@interface AddVC ()<UINavigationControllerDelegate ,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *imageBtn;
@property (weak, nonatomic) IBOutlet UITextField *listName;
@property (weak, nonatomic) IBOutlet UITextField *listAdress;
@property (nonatomic, strong) UIImage *selectImage;

@end

@implementation AddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    self.infoDict = [NSMutableDictionary dictionary];
}

- (IBAction)addImageAction:(UIButton *)sender {
    [self chooseImage];
}

- (IBAction)determineAction:(UIBarButtonItem *)sender {
    //未填写ListName
    if (self.listName.text.length == 0) {
        UILabel *popLabel = [[UILabel alloc]init];
        popLabel.bounds = CGRectMake(0, 0, 200, 50);
        popLabel.center = CGPointMake(kScreenW / 2, kScreenH / 2);
        popLabel.layer.cornerRadius = 10;
        popLabel.clipsToBounds = YES;
        popLabel.text = @"请填写清单名称";
        popLabel.font = [UIFont systemFontOfSize:14];
        popLabel.textAlignment = NSTextAlignmentCenter;
        popLabel.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:popLabel];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:popLabel selector:@selector(removeFromSuperview) userInfo:nil repeats:NO];
        return;
    }
    //未填写ListAdress
    if (self.listAdress.text.length == 0) {
        UILabel *popLabel = [[UILabel alloc]init];
        popLabel.bounds = CGRectMake(0, 0, 200, 50);
        popLabel.center = CGPointMake(kScreenW / 2, kScreenH / 2);
        popLabel.layer.cornerRadius = 10;
        popLabel.clipsToBounds = YES;
        popLabel.text = @"请填写目的地";
        popLabel.font = [UIFont systemFontOfSize:14];
        popLabel.textAlignment = NSTextAlignmentCenter;
        popLabel.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:popLabel];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:popLabel selector:@selector(removeFromSuperview) userInfo:nil repeats:NO];
        return;
    }
    //都已填写完成
    if (self.listName.text.length != 0 && self.listAdress.text.length != 0) {
        NSData *data = UIImagePNGRepresentation(self.selectImage);
        [self.infoDict setValue:data forKey:@"imageData"];
        [self.infoDict setValue:_listName.text forKey:@"listName"];
        [self.infoDict setValue:_listAdress.text forKey:@"listAdress"];
        //使用block块属性之前，需要判断是否为空
        if (self.pass) {
            //调用block块，来触发内部更改descLabel文本
            self.pass(self.infoDict);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)getPassInfoDict:(passInfoDict)block
{
    self.pass = block;
}

- (IBAction)cancelAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//调用相机和图库
- (void)chooseImage
{
    //创建UIAlertController
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选取照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //创建AlertAction
    UIAlertAction *imageAction = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 跳转相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        // 跳转相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    // 判断是否支持相机，添加对应的Action
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [alertController addAction:imageAction];
        [alertController addAction:photoAction];
        [alertController addAction:cancelAction];
    }
    else {
        [alertController addAction:imageAction];
        [alertController addAction:cancelAction];
    }
    //显示AlertController
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}

#pragma mark - 照片选取代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    self.selectImage = image;
    [self.imageBtn setBackgroundImage:image forState:UIControlStateNormal];
}

@end
