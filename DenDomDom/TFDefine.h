//
//  TFDefine.h
//  ShopOnline
//
//  Created by Long Dang on 8/6/15.
//  Copyright (c) 2015 tflat. All rights reserved.
//

#ifndef ShopOnline_TFDefine_h
#define ShopOnline_TFDefine_h
#define RGB(r, g, b)                                [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define kConfig_IsDebug                                         YES
#define kConfig_IsBultForTesting                                NO


#pragma mark - Storyboard       
#define kStoryboard_Main                                        [UIStoryboard storyboardWithName:@"Main" bundle:nil];


#pragma mark - Segue
//----------------------------------------------
#define kSegue_Push_Home_Detail                                 @"kSegue_Push_Home_Detail"
#define kSegue_Push_Home_Filter                                 @"kSegue_Push_Home_Filter"
#define kSegue_Push_Filter_FilterDetail                         @"kSegue_Push_Filter_FilterDetail"

#pragma mark - Storyboard ID
//----------------------------------------------
#define kStoryboardID_HomeController                           @"kStoryboardID_HomeController"
#define kStoryboardID_ScholarshipDetailController              @"kStoryboardID_ScholarshipDetailController"
#define kStoryboardID_LeftSlideController                      @"kStoryboardID_LeftSlideController"

#define kStoryboardID_AboutController                           @"kStoryboardID_AboutController"

#pragma mark - User Default
//----------------------------------
#define kUserDefault_IsTheFirstTime                             @"kUserDefault_IsTheFirstTime"
#define kUserDefault_UserAccount                                @"kUserDefault_UserAccount"

#pragma mark - Praram Social
//--------------------------------------------------------
#define kParam_Provider_ID                                      @"provider_id"
#define kParam_Provider                                         @"provider"
#define kParam_Email                                            @"email"
#define kParam_Image                                            @"image"
#define kParam_Gender                                           @"gender"
#define kParam_Location                                         @"location"
#define kParam_BirthDay                                         @"birthday"
#define kParam_Name                                             @"name"

#pragma mark - Format Date
//----------------------------------
#define kTimerFormat                                            @"mm:ss.SS"
#define kFormat_HHmm                                            @"HH:mm"
#define kFormat_ddMMyyyy                                        @"dd/MM/yyyy"

#pragma mark - StoryboardId
//----------------------------------
#define kStoryboardId_ChatController                            @"kStoryboardId_ChatController"


#pragma mark - Cell Id
//------------------------
#define kCellId_Home                                            @"kCellId_Home"
#define kCellId_Comment                                         @"kCellId_Comment"
#define kCellId_LeftSlide                                       @"kCellId_LeftSlide"
#define kCellId_Filter                                          @"kCellId_Filter"
#define kCellId_FilterDetail                                    @"kCellId_FilterDetail"
#define kCellId_InfoDetail                                      @"kCellId_InfoDetail"

#pragma mark - font name
//----------------------------------
#define kFont_System_Normal                                     @"HelveticaNeue"
#define kFont_System_Medium                                     @"HelveticaNeue-Medium"
#define kFont_System_Bold                                       @"HelveticaNeue-Bold"
#define kFont_System_Light                                      @"HelveticaNeue-Light"


#pragma mark - Filter Type
//----------------------------------
#define kFilterType_Gender                                      @"Giới tính"
#define kFilterType_NoiO                                        @"Nơi ở"
#define kFilterType_Religion                                    @"Tôn giáo"
#define kFilterType_Disability                                  @"Khuyết tật"
#define kFilterType_TerminalIll                                 @"Tình trạng đặc biệt"
#define kFilterType_Family_Policy                               @"Gia đình chính sách"
#define kFilterType_AcademicLevelNow                              @"Trình độ hiện tại"
#define kFilterType_AcademicLevel                               @"Trình độ của học bổng"
#define kFilterType_Major                                       @"Chuyên ngành"
#define kFilterType_ScholarshipType                             @"Loại học bổng"
#define kFilterType_Talent                                      @"Năng khiếu"

#pragma mark - TypeID
//------------------------------------
#define kFilterNew                                              1
#define kFilterFilter                                           5
#define kFilterNoiBat                                           2
#define kFilterDuHoc                                            3
#pragma mark - TextFieldValidation
//------------------------------------
#define kRegex_Email                                            @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define kRegex_PasswordLimit                                    @"^.{5,50}$"
#define kRegex_PasswordChar                                     @"[A-Za-z0-9]{5,20}"
#define kRegex_PhoneNumer                                       @"[0-9]{9,10}"
#define kRegex_NameLimit                                        @"^.{2,50}$"
#endif
