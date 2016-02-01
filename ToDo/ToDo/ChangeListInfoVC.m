//
//  ChangeListInfoVC.m
//  ToDo
//
//  Created by qingyun on 16/2/1.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ChangeListInfoVC.h"
#import "DataBaseEngine.h"
#import "Common.h"
#import "ListModel.h"

@interface ChangeListInfoVC ()<UINavigationControllerDelegate ,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *imageBtn;
@property (weak, nonatomic) IBOutlet UITextField *listName;
@property (weak, nonatomic) IBOutlet UITextField *listAdress;
@property (nonatomic, strong) UIImage *selectImage;
@property (nonatomic, strong) ListModel *currentModel;
@end

@implementation ChangeListInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentModel = [DataBaseEngine getListModelWithListSort:self.sort];
    [_imageBtn setBackgroundImage:[UIImage imageWithData:(NSData *)_currentModel.image] forState:UIControlStateNormal];
    _listName.text = _currentModel.name;
    _listAdress.text = _currentModel.relatedpoi;
    _selectImage = [UIImage imageWithData:(NSData *)_currentModel.image];
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
        NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
        if (self.selectImage == nil) {
            self.selectImage = [UIImage imageNamed:@"listPlaceholderImage"];
        }
        NSData *data = UIImagePNGRepresentation(self.selectImage);
        [infoDict setValue:data forKey:@"image"];
        [infoDict setValue:_listName.text forKey:@"name"];
        [infoDict setValue:_listAdress.text forKey:@"relatedpoi"];
        [infoDict setValue:@(self.sort) forKey:@"sort"];
        [DataBaseEngine updataTraveListWithInfoDict:infoDict];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
